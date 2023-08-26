from repositories.mysql.mysql_db import MySqldb
from Crypto.Cipher import AES
from binascii import hexlify, unhexlify
import base64

class UserModel:
    def ComprobarCredenciales(usr:str, pwd:str):

        # desencriptar correo
        key = unhexlify("0123456789abcdef0123456789abcdef")
        iv = unhexlify("abcdef9876543210abcdef9876543210")

        usr_hex = unhexlify(base64.b64decode(usr).hex())

        cipher = AES.new(key, AES.MODE_CBC, iv)
        decrypted_data = cipher.decrypt(usr_hex)

        padding_size = decrypted_data[-1]
        data_plana = decrypted_data[:-padding_size]

        correo = data_plana.decode('utf-8').strip()

        #print(correo)

        query = f"select * from users where correo = '{correo}' and contrasena = '{pwd}'"
        ret = MySqldb().execute_query(query)

        try:
            Usuario = ret[0]
            return Usuario
        except Exception:
            Exception("Usuario o contraseña incorrectos")

    
    def guardarToken(id:int, token:str):
        params = [
            {
                "nombre":"id",
                "valor":id
            },
            {
                "nombre":"token",
                "valor":token
            },
        ]
        query = ("INSERT INTO `user_session` "
                 "(id_user,token) "
                "values(%s,%s)")
        try:
            MySqldb().execute_insert(query,params)
            #MySqldb().execute_query(query)
        except Exception as e:
            print(str(e))
        
        return


    def obtenerSesion(id:int, token:str):
        query = f"select * from user_session where id_user='{id}' and token='{token}'"
        ret = MySqldb().execute_query(query)
        return ret[0]
    

    def isValidToken(token):
        query = ("select * from user_session "
        f"where token='{token}' "
        "and created_at <= now() "
        "and expires_at >=now()")
        ret = MySqldb().execute_query(query)
        return ret[0]
    

    def menuPrincipal(id_usuario):
        query = (
            "select a.id,a.nombre from accesos a "
            "inner join acceso_por_rol b on a.id = b.id_acceso "
            "inner join roles c on b.id_rol = c.id "
            "inner join roles_por_usuario d on c.id = d.id_rol "
            "where a.id_acceso_padre IS null "
            "and b.permitido = 1 "
            f"and d.id_user = {id_usuario} "
            "group by a.id,a.nombre"
        )
        print(query)
        ret = MySqldb().execute_query(query)
        return ret
    

    def accesos(id_acceso,id_usuario):
        query = (
            "select a.id,a.nombre,a.ruta from accesos a "
            "inner join acceso_por_rol b on a.id = b.id_acceso "
            "inner join roles c on b.id_rol = c.id "
            "inner join roles_por_usuario d on c.id = d.id_rol "
            f"where a.id_acceso_padre = {id_acceso} "
            f"and d.id_user = {id_usuario} "
            "group by a.id,a.nombre,a.ruta"
        )
        print(query)
        ret = MySqldb().execute_query(query)
        return ret