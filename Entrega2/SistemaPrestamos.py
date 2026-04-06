#hago un from para traer librerias de tipo lista
from ast import List
#hago este from para unir la logica de clases de modelo.py
from modelos import *
#Hago esto para traer propiedad de clear del SO
import os

class SistemaPrestamos:
#Funciones auxiliares: ayudan a validar entradas, registros y otros
    #Funcion que inicializa arreglos como lista dinamica
    def __init__(self):
        self.alumnos: List[Alumno] = []
        self.docentes: List[Docente] = []
        self.materiales: List[Material] = []
        self.prestamos: List[Prestamo] = []
        self.devoluciones: List[Devolucion] = []
        #Se han omitido variables de login en esta entrega
        #self.usuario_admin = "admin"
        #self.password_admin = "admin"

    #Funcion que valida RUT por MOD11
    def validar_rut_mod11(self, rut: str) -> bool:
        try:
            cuerpo, dv = rut.split("-")
            dv = dv.upper()
        except:
            return False
        if not cuerpo.isdigit():
            return False
        suma = 0
        factor = 2
        for digito in reversed(cuerpo):
            suma += int(digito) * factor
            factor += 1
            if factor > 7:
                factor = 2
        resto = 11 - (suma % 11)
        if resto == 11:
            dv_esperado = "0"
        elif resto == 10:
            dv_esperado = "K"
        else:
            dv_esperado = str(resto)
        return dv == dv_esperado
    
    #Funcion que valida que RUT no exista previamente como alumno o docente en ingreso
    def rut_existe_general(self, rut: str) -> bool:
        for alumno in self.alumnos:
            if alumno.rut == rut:
                return True
        for docente in self.docentes:
            if docente.rut == rut:
                return True
        return False
    
    #Funcion que valida ingreso numerico cuando corresponda, evita caidas de sistema
    def pedir_entero(self, mensaje: str, minimo=None, maximo=None) -> int:
        while True:
            try:
                valor = int(input(mensaje))
                if minimo is not None and valor < minimo:
                    print(f"El valor debe ser mayor o igual a {minimo}")
                    continue
                if maximo is not None and valor > maximo:
                    print(f"El valor debe ser menor o igual a {maximo}")
                    continue
                return valor
            except:
                print("Ingrese un numero entero valido.")

    #Funciones que valida email
    def pedir_email(self, mensaje: str) -> str:
        while True:
            email = input(mensaje)
            if "@" not in email:
                print("Email invalido.Sin arroba")
                continue
            partes = email.split("@")
            if len(partes) != 2:
                print("Email invalido.Falta cuerpo o dominio")
                continue
            usuario, dominio = partes
            if usuario == "" or dominio == "":
                print("Email invalido. Blancos")
                continue
            if "." not in dominio:
                print("Email invalido. Error de dominio")
                continue
            if " " in email:
                print("Email invalido. Error de dominio")
                continue
            return email

    #Funcion para evitar blancos o null
    def pedir_texto(self, mensaje: str) -> str:
        while True:
            texto = input(mensaje)
            if texto is None:
                print("Ingrese un valor valido.")
                continue
            texto = texto.strip()
            if texto == "":
                print("No puede estar vacio.")
                continue
            return texto
    
    #Funcion que permite buscar materiales en array
    def buscar_material_por_codigo(self, codigo: str) -> Optional[Material]:
        for material in self.materiales:
            if material.codigo == codigo:
                return material
        return None
    
    #Funcion que permite buscar prestamos en array para devolucion
    def buscar_prestamo_por_numero(self, numero: int) -> Optional[Prestamo]:
        for prestamo in self.prestamos:
            if prestamo.numero == numero:
                return prestamo
        return None

    #Funcion que permite buscar prestamos ya devueltos para no generar doble devolución en array
    def prestamo_ya_devuelto(self, numero_prestamo: int) -> bool:
        return any(d.numero_prestamo == numero_prestamo for d in self.devoluciones)
    
    #Funcion dedicada a determinar si RUT es de alumno o docente, utilizada en reporte prestamos y devoluciones
    def buscar_persona_por_rut(self, rut: str):
        for alumno in self.alumnos:
            if alumno.rut == rut:
                return alumno, "ALUMNO"
        for docente in self.docentes:
            if docente.rut == rut:
                return docente, "DOCENTE"
        return None, None
    
    #Funcion para limpiar pantalla
    def limpiar_pantalla(self):
        if os.name == "nt":
            os.system("cls")
        else:
            os.system("clear")
    #Funcion de pausa
    def pausar_tecla(self):
        input("\nPresione ENTER para continuar...")

#Metodo registrar alumnos    
    def registrar_alumno(self):
        rut = input("RUT: ")
        #Valido por MOD11 el RUT con funcion
        if not self.validar_rut_mod11(rut):
            print("RUT invalido (modulo 11).")
            return
        #Valido que el rut no este ya registrado
        if self.rut_existe_general(rut):
            print("El RUT ya existe en el sistema.")
            return
        #Si RUT OK, sigo ingresando data
        #Valido que no ingresen null
        nombre = self.pedir_texto("Nombre: ")
        calle = self.pedir_texto("Calle: ")
        #Valido que se haya ingresado un entero, para evitar caida
        numero = self.pedir_entero("Numero: ", minimo=1, maximo=99999)
        region = self.pedir_texto("Region: ")
        comuna = self.pedir_texto("Comuna: ")
        #Valido estructura del email
        email = self.pedir_email("Email: ")
        telefono = self.pedir_entero("Telefono: ", minimo=111111111, maximo=999999999)
        grado = self.pedir_texto("Grado: ")

        #Cargo en list alumno la informacion ingresada
        alumno = Alumno(
            rut=rut,nombre=nombre,
            calle=calle,numero = int(numero),
            region=region,comuna=comuna,
            email=email,telefono=telefono,grado=grado)
        #Introduzco en array dinamico al final
        self.alumnos.append(alumno)
        print("Alumno registrado correctamente.")

#Metodo registrar docente
    def registrar_docente(self):
        rut = input("RUT: ")
        #Valido por MOD11 el RUT con funcion
        if not self.validar_rut_mod11(rut):
            print("RUT invalido (modulo 11).")
            return
        #Valido que el rut no este ya registrado
        if self.rut_existe_general(rut):
            print("El RUT ya existe en el sistema.")
            return
        
        #Si RUT OK, sigo ingresando data
        #Valido que no ingresen null
        nombre = self.pedir_texto("Nombre: ")
        calle = self.pedir_texto("Calle: ")
        #Valido que se haya ingresado un entero, para evitar caida
        numero = self.pedir_entero("Numero: ", minimo=1, maximo=99999)
        region = self.pedir_texto("Region: ")
        comuna = self.pedir_texto("Comuna: ")
        #Valido estructura del email
        email = self.pedir_email("Email: ")
        telefono = self.pedir_entero("Telefono: ", minimo=111111111, maximo=999999999)
        grado_asignado = self.pedir_texto("Grado: ")
        profesion = self.pedir_texto("Profesion: ")

        docente = Docente(
            rut=rut,nombre=nombre,calle=calle,
            numero=numero,region=region,comuna=comuna,
            email=email,telefono=telefono,
            profesion=profesion,grado_asignado=grado_asignado)
        self.docentes.append(docente)
        print("Docente registrado correctamente.")

#Metodo registrar material
    def registrar_material(self):
        codigo = self.pedir_entero("Codigo: ", minimo=1, maximo=99999)
        #Valido si existe codigo de material
        if self.buscar_material_por_codigo(codigo) is not None:
            print("El codigo de material ya existe.")
            return
        descripcion=self.pedir_texto("Descripción: ")
        #Especifico tipo en un submenú de opciones controlado, puede caerse si python es menor 3.1 en match
        print("Indique tipo Material\n1-MATERIAL\n2-HERRAMIENTA\n3-EQUIPO")
        tipo=self.pedir_entero("Tipo: ", minimo=1, maximo=3)
        match tipo:
            case 1:
                tipo="MATERIAL"
            case 2:
                tipo="HERRAMIENTA"
            case 3:
                tipo="EQUIPO"
            case _:
                tipo="Error en registro"   
        modelo=self.pedir_texto("Modelo: ")
        serial=self.pedir_texto("Serial: ")
        costo=self.pedir_entero("Costo: ", minimo=1, maximo=99999)
        stock_total=self.pedir_entero("Stock Total: ",minimo=1, maximo=99999)
        
        material = Material(
            codigo=codigo,descripcion=descripcion,tipo=tipo,
            modelo=modelo,serial=serial,costo=costo,
            stock_total=stock_total,stock_disponible=stock_total)
        self.materiales.append(material)
        print("Material registrado correctamente.")

#Metodo registrar prestamo: Maneja de 1 a n materiales en 1 prestamo
#   Inicio registro        
    def registrar_prestamo(self, rut_solicitante: str, fecha: str, descripcion: str):
        numero = len(self.prestamos) + 1
        prestamo = Prestamo(
            numero=numero,fecha=fecha,
            rut_solicitante=rut_solicitante,
            descripcion=descripcion
        )
        return prestamo
    
    #Detalle prestamo
    def agregar_detalle_a_prestamo_objeto(self, prestamo, codigo_material: int, cantidad: int):
        material = self.buscar_material_por_codigo(codigo_material)
        
        if any(d.codigo_material == codigo_material for d in prestamo.detalles):
            print("Ese material ya fue agregado a este prestamo.")
            return
     
        detalle = DetallePrestamo(
            codigo_material=codigo_material,
            cantidad=cantidad,
            monto=material.costo * cantidad
        )
        prestamo.detalles.append(detalle)
        material.stock_disponible -= cantidad
        print("Material agregado al prestamo.")

    #Guardo
    def guardar_prestamo(self, prestamo):
        self.prestamos.append(prestamo)
        print(f"Prestamo #{prestamo.numero} creado para {prestamo.rut_solicitante}")

#Metodo registrar devolucion: Se maneja como una devolución absoluta, no parcial       
    def registrar_devolucion(self, numero_prestamo: int, fecha: str):
        prestamo = self.buscar_prestamo_por_numero(numero_prestamo)

        if prestamo is None:
            print("El numero de prestamo no existe.")
            return

        if self.prestamo_ya_devuelto(numero_prestamo):
            print("Ese prestamo ya fue devuelto.")
            return

        numero_devolucion = len(self.devoluciones) + 1
        descripcion=self.pedir_texto("Descripcion devolucion: ")
        devolucion = Devolucion(
            numero=numero_devolucion,
            numero_prestamo=numero_prestamo,
            fecha=fecha,
            descripcion=descripcion
        )

        for detalle in prestamo.detalles:
            if not detalle.esta_devuelto():
                material = self.buscar_material_por_codigo(detalle.codigo_material)
                if material:
                    material.stock_disponible += detalle.cantidad

                detalle.numero_devolucion = numero_devolucion
                detalle.fecha_devolucion = fecha

        self.devoluciones.append(devolucion)
        print("Devolucion registrada correctamente.")

#Metodo reporte alumnos        
    def reporte_alumnos(self):
        print("=========== REPORTE ALUMNOS ===========")
        if not self.alumnos:
            print("No hay alumnos registrados.")
            return
        for i, alumno in enumerate(self.alumnos, start=1):
            print(f"Alumno N° {i}")
            print(f"RUT: {alumno.rut}")
            print(f"Nombre: {alumno.nombre}")
            print(f"Direccion: {alumno.calle} {alumno.numero}")
            print(f"Region: {alumno.region}")
            print(f"Comuna: {alumno.comuna}")
            print(f"Email: {alumno.email}")
            print(f"Telefono: {alumno.telefono}")
            print(f"Grado: {alumno.grado}")
            print("---------------------------------------")
#Metodo reporte docentes        
    def reporte_docentes(self):
        print("=========== REPORTE DOCENTES ===========")
        if not self.docentes:
            print("No hay docentes registrados.")
            return
        for i, docente in enumerate(self.docentes, start=1):
            print(f"Docente N° {i}")
            print(f"RUT: {docente.rut}")
            print(f"Nombre: {docente.nombre}")
            print(f"Direccion: {docente.calle}  {docente.numero}")
            print(f"Region: {docente.region}")
            print(f"Comuna: {docente.comuna}")
            print(f"Email: {docente.email}")
            print(f"Telefono: {docente.telefono}")
            print(f"Grado: {docente.grado_asignado}")
            print(f"Profesion: {docente.profesion}")
            print("---------------------------------------")

#Metodo reporte prestamos        
    #Global
    def reporte_prestamos_global(self):
        print("========== REPORTE PRESTAMOS GLOBAL==========")
        if not self.prestamos:
            print("________________________________\nNo hay prestamos registrados.")
            return

        for prestamo in self.prestamos:
            print(f"Numero prestamo: {prestamo.numero}")
            print(f"Fecha: {prestamo.fecha}")
            print(f"RUT solicitante: {prestamo.rut_solicitante}")
            print(f"Descripcion: {prestamo.descripcion}")
            print("Detalle:")

            for detalle in prestamo.detalles:
                print(
                    f"Codigo: {detalle.codigo_material} | "
                    f"Cantidad: {detalle.cantidad} | "
                    f"Monto: {detalle.monto}"
                )

                if detalle.esta_devuelto():
                    print(
                        f"  Estado: DEVUELTO | "
                        f"N° devolucion: {detalle.numero_devolucion} | "
                        f"Fecha devolucion: {detalle.fecha_devolucion}"
                    )
                else:
                    print("  Estado: PENDIENTE DEVOLUCION")

            print("---------------------------------------")
    #Por tipo Material
    def reporte_prestamos_por_tipo(self, tipo_busqueda: str):
        print(f"==== PRESTAMOS POR MATERIAL TIPO {tipo_busqueda} ====")
        if not self.prestamos:
            print("No hay prestamos registrados.")
            return
        total_monto = 0
        encontrados = False
        for prestamo in self.prestamos:
            tiene_tipo = False
            for detalle in prestamo.detalles:
                material = self.buscar_material_por_codigo(detalle.codigo_material)
                if material is not None and material.tipo == tipo_busqueda:
                    if not tiene_tipo:
                        print(f"Prestamo N° {prestamo.numero}")
                        print(f"Fecha: {prestamo.fecha}")
                        print(f"RUT solicitante: {prestamo.rut_solicitante}")
                        print(f"Descripcion: {prestamo.descripcion}")
                        print("---- Detalle materiales ----")
                        tiene_tipo = True
                        encontrados = True
                    print(
                    f"Codigo: {detalle.codigo_material} | "
                    f"Tipo: {material.tipo} | "
                    f"Cantidad: {detalle.cantidad} | "
                    f"Monto: {detalle.monto}")
                    total_monto += detalle.monto
            if tiene_tipo:
                print("------------------------------------------------------")
        if not encontrados:
            print(f"No hay prestamos registrados para el tipo {tipo_busqueda}.")
            return
        print("======================================================")
        print(f"TOTAL PRESTADO TIPO {tipo_busqueda}: {total_monto}")
        print("======================================================")
           
    #Por Persona
    def reporte_prestamos_por_persona(self, rut_busqueda: str):
        print("====== REPORTE DE PRESTAMOS POR PERSONA ======")
        if not self.prestamos:
            print("No hay prestamos registrados.")
            return
        #Uso funcion auxiliar solo para indicar tipo persona y nombre
        persona, tipo_persona = self.buscar_persona_por_rut(rut_busqueda)
        if persona is None:
            print("La persona no existe en el sistema.")
            return
        encontrados = False
        total_monto = 0
        print("======================================================")
        print(f"Tipo persona: {tipo_persona}")
        print(f"RUT: {persona.rut}")
        print(f"Nombre: {persona.nombre}")
        print("------------------------------------------------------")
        for prestamo in self.prestamos:
            if prestamo.rut_solicitante != rut_busqueda:
                continue
            encontrados = True
            print(f"Prestamo N° {prestamo.numero}")
            print(f"Fecha: {prestamo.fecha}")
            print(f"Descripcion: {prestamo.descripcion}")
            print("---- Detalle materiales prestados ----")

            for detalle in prestamo.detalles:
                material = self.buscar_material_por_codigo(detalle.codigo_material)
                if material is not None:
                    print(
                    f"Codigo: {detalle.codigo_material} | "
                    f"Tipo: {material.tipo} | "
                    f"Cantidad: {detalle.cantidad} | "
                    f"Monto: {detalle.monto}")
                else:
                    print(
                    f"Codigo: {detalle.codigo_material} | "
                    f"Cantidad: {detalle.cantidad} | "
                    f"Monto: {detalle.monto}")
                total_monto += detalle.monto
        print("------------------------------------------------------")
        if not encontrados:
            print("No hay prestamos registrados para esta persona.")
            return
        print("======================================================")
        print(f"TOTAL PRESTADO POR LA PERSONA: {total_monto}")
        print("======================================================")


#Metodo reporte devoluciones        
    #Global
    def reporte_devoluciones_global(self):
        print("========== REPORTE DEVOLUCIONES GLOBAL ==========")
        if not self.devoluciones:
            print("________________________________\nNo hay devoluciones registradas.")
            return
        for i, devolucion in enumerate(self.devoluciones, start=1):
            print(f"Devolucion N° {i}")
            print(f"Numero devolucion: {devolucion.numero}")
            print(f"Numero prestamo asociado: {devolucion.numero_prestamo}")
            print(f"Fecha devolucion: {devolucion.fecha}")
            print(f"Descripcion: {devolucion.descripcion}")
        prestamo = self.buscar_prestamo_por_numero(devolucion.numero_prestamo)
        if prestamo is not None:
            print("---- Detalle del prestamo asociado ----")
            print(f"RUT solicitante: {prestamo.rut_solicitante}")
            print(f"Fecha prestamo: {prestamo.fecha}")
            print(f"Descripcion prestamo: {prestamo.descripcion}")
            print("---------------------------------------")
            for detalle in prestamo.detalles:
                if detalle.numero_devolucion == devolucion.numero:
                    print(
                    f"Codigo: {detalle.codigo_material} | "
                    f"Cantidad: {detalle.cantidad} | "
                    f"Monto: {detalle.monto}"
                    )
    #Por tipo Material
    def reporte_devoluciones_por_tipo(self, tipo_busqueda: str):
        print(f"==== DEVOLUCIONES PPOR MATERIAL TIPO {tipo_busqueda} ====")
        if not self.devoluciones:
            print("No hay devoluciones registradas.")
            return
        total_monto = 0
        encontrados = False
        for devolucion in self.devoluciones:
            prestamo = self.buscar_prestamo_por_numero(devolucion.numero_prestamo)
            if prestamo is None:
                continue
            for detalle in prestamo.detalles:
                if detalle.numero_devolucion != devolucion.numero:
                    continue
                material = self.buscar_material_por_codigo(detalle.codigo_material)
                if material is None:
                    continue
                if material.tipo == tipo_busqueda:
                    encontrados = True
                    print(f"Devolucion N° {devolucion.numero}")
                    print(f"Fecha: {devolucion.fecha}")
                    print(f"Codigo material: {detalle.codigo_material}")
                    print(f"Tipo: {material.tipo}")
                    print(f"Cantidad: {detalle.cantidad}")
                    print(f"Monto: {detalle.monto}")
                    print("---------------------------------------")
                total_monto += detalle.monto
        if not encontrados:
            print(f"No hay devoluciones para el tipo {tipo_busqueda}.")
            return
        print("=======================================")
        print(f"TOTAL DEVUELTO TIPO {tipo_busqueda}: {total_monto}")
        print("=======================================")
    #Por Persona
    def reporte_devoluciones_por_persona(self, rut_busqueda: str):
        print("====== REPORTE DE DEVOLUCIONES POR PERSONA ======")
        if not self.devoluciones:
            print("No hay devoluciones registradas.")
            return
        #Uso funcion auxiliar solo para indicar tipo persona y nombre
        persona, tipo_persona = self.buscar_persona_por_rut(rut_busqueda)
        if persona is None:
            print("La persona no existe en el sistema.")
            return
        encontrados = False
        total_monto = 0
        print("======================================================")
        print(f"Tipo persona: {tipo_persona}")
        print(f"RUT: {persona.rut}")
        print(f"Nombre: {persona.nombre}")
        print("------------------------------------------------------")
        for devolucion in self.devoluciones:
            prestamo = self.buscar_prestamo_por_numero(devolucion.numero_prestamo)
            if prestamo is None:
                continue
            if prestamo.rut_solicitante != rut_busqueda:
                continue
            encontrados = True
            print(f"Devolucion N° {devolucion.numero}")
            print(f"Numero prestamo asociado: {devolucion.numero_prestamo}")
            print(f"Fecha devolucion: {devolucion.fecha}")
            print(f"Descripcion devolucion: {devolucion.descripcion}")
            print(f"Fecha prestamo: {prestamo.fecha}")
            print(f"Descripcion prestamo: {prestamo.descripcion}")
            print("---- Detalle materiales devueltos ----")
            for detalle in prestamo.detalles:
                if detalle.numero_devolucion == devolucion.numero:
                    print(
                        f"Codigo: {detalle.codigo_material} | "
                        f"Cantidad: {detalle.cantidad} | "
                        f"Monto: {detalle.monto}"
                    )
                    total_monto += detalle.monto
            print("------------------------------------------------------")
        if not encontrados:
            print("No hay devoluciones registradas para esta persona.")
            return
        print("======================================================")
        print(f"TOTAL DEVUELTO POR LA PERSONA: {total_monto}")
        print("======================================================")

#Metodo reporte materiales
#   Global        
    def reporte_materiales_global(self):
        print("========= REPORTE DE MATERIALES GLOBAL=========")
        if not self.materiales:
            print("No hay materiales registrados.")
            return
        for i, material in enumerate(self.materiales, start=1):
            print(f"Material N° {i}")
            print(f"Codigo: {material.codigo}")
            print(f"Descripcion: {material.descripcion}")
            print(f"Tipo: {material.tipo}")
            print(f"Modelo: {material.modelo}")
            print(f"Serial: {material.serial}")
            print(f"Costo: {material.costo}")
            print(f"Stock total: {material.stock_total}")
            print(f"Stock disponible: {material.stock_disponible}")
            print(f"Valor Total Material: {material.costo * material.stock_total}")
            print(f"Valor Disponible Material: {material.costo * material.stock_disponible}")
            print("-----------------------------------------")
    #por tipo
    def reporte_materiales_por_tipo(self, tipo_busqueda: str):
        print(f"==== REPORTE DE MATERIALES TIPO {tipo_busqueda} ====")
        if not self.materiales:
            print("No hay materiales registrados.")
            return
        encontrados = False
        total_general_tipo = 0
        total_disponible_tipo = 0
        for i, material in enumerate(self.materiales, start=1):
            if material.tipo == tipo_busqueda:
                encontrados = True
                valor_total = material.costo * material.stock_total
                valor_disponible = material.costo * material.stock_disponible
                total_general_tipo += valor_total
                total_disponible_tipo += valor_disponible
                print(f"Material N° {i}")
                print(f"Codigo: {material.codigo}")
                print(f"Descripcion: {material.descripcion}")
                print(f"Tipo: {material.tipo}")
                print(f"Modelo: {material.modelo}")
                print(f"Serial: {material.serial}")
                print(f"Costo: {material.costo}")
                print(f"Stock total: {material.stock_total}")
                print(f"Stock disponible: {material.stock_disponible}")
                print(f"Valor Total Material: {valor_total}")
                print(f"Valor Disponible Material: {valor_disponible}")
                print("-----------------------------------------")
        if not encontrados:
            print(f"No hay materiales del tipo {tipo_busqueda}.")
            return
        print("=========================================")
        print(f"TOTAL INVENTARIO TIPO {tipo_busqueda}: {total_general_tipo}")
        print(f"TOTAL DISPONIBLE TIPO {tipo_busqueda}: {total_disponible_tipo}")
        print("=========================================")
