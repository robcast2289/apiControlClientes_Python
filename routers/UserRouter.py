from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.responses import JSONResponse
from schemas.UserSchema import LoginRequest
from models.UserModel import UserModel
import datetime
import hashlib
import base64

import mysql.connector

router = APIRouter(
    prefix="/User",
    tags=["User"],
)

@router.post('/login')
async def login(model:LoginRequest):
    ret = UserModel.ComprobarCredenciales(model.correo,model.contrasena)
    if ret is None:
        return JSONResponse(
            status_code=status.HTTP_400_BAD_REQUEST,
            content={
                "error":True,
                "mensaje":"Usuario y/o contraseña no son válidos"
            }
        )

    date = datetime.datetime.now()
    stringTk = ret["Correo"]+str(date)
    hash_obj = hashlib.new('md5')
    hash_obj.update(stringTk.encode('utf-8'))
    token = hash_obj.hexdigest()
    try:
        UserModel.guardarToken(ret["Id"],token)        
        sesion = UserModel.obtenerSesion(ret["Id"],token)
    except:
        return JSONResponse(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            content={
                "error":True,
                "mensaje":"Error al guardar sesion"
            }
        )    

    respuesta = {
        "error":False,
        "token":token,
        "expires_at":sesion["Expires_At"],
        "id_user":ret["Id"],
        "user":ret
    }
    return respuesta


@router.get('/menu/{id_usuario}/{token}')
async def menu(id_usuario,token):

    session = UserModel.isValidToken(token)

    if session is None:
        return JSONResponse(
            status_code=status.HTTP_400_BAD_REQUEST,
            content={
                "error":True,
                "mensaje":"Token inválido"
            }
        )        

    menus = UserModel.menuPrincipal(id_usuario)

    menuAll = []

    for menu in menus:
        accesos = UserModel.accesos(menu["Id"],id_usuario)
        access = {
            "id":menu["Id"],
            "nombre":menu["Nombre"],
            "submenu":accesos
        }
        menuAll.append(access)
    
    return {
        "error":False,
        "opciones":menuAll
    }

@router.post('/test')
async def test():
    cnx = mysql.connector.connect(
        host='localhost',
        user='root',
        password='',
        database='controlclientes'
    )
    cursor = cnx.cursor()

    add_session = ("INSERT INTO `user_session` "
                 "(id_user,token) "
                "values(%s,%s)")
    
    data_session = (1,'123456789')

    cursor.execute(add_session,data_session)
    sess_no = cursor.lastrowid

    cnx.commit()
    cursor.close()
    cnx.close()

    return sess_no