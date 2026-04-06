#Este import conecta a clase controlador Sistema prestamos y permite usar funciones y metodos de la misma
import SistemaPrestamos
#Usare este import para obtener fecha del sistema
from datetime import date

def menu():
    sistema = SistemaPrestamos.SistemaPrestamos()
    while True:
        #limpio pantalla por cada iteracion
        sistema.limpiar_pantalla()
        print("\n=======================================")
        print(" SISTEMA DE PRESTAMOS - ESCUELA")
        print("=======================================")
        print("1. Agregar Alumno")
        print("2. Agregar Docente")
        print("3. Registrar Material")
        print("4. Registrar Prestamo")
        print("5. Registrar Devolucion")
        print("6. Reporte Personas")
        print("7. Reporte Prestamos")
        print("8. Reporte Devoluciones")
        print("9. Reporte Materiales")
        print("10. Salir")
        #Manejo excepción de numero opcion en menu
        opc = sistema.pedir_entero("Seleccione una opción: ", minimo=1, maximo=10)
        if opc == 1:
            sistema.limpiar_pantalla()
            sistema.registrar_alumno()
            sistema.pausar_tecla()
        elif opc == 2:
            sistema.limpiar_pantalla()
            sistema.registrar_docente()
            sistema.pausar_tecla()
        elif opc == 3:
            sistema.limpiar_pantalla()
            sistema.registrar_material()
            sistema.pausar_tecla()
        elif opc == 4:
            sistema.limpiar_pantalla()
            print("=======================================")
            print("======INGRESO PRESTAMOS=======")
            rut_solicitante=input("RUT solicitante: ")
            if not sistema.validar_rut_mod11(rut_solicitante):
                print("RUT invalido (modulo 11).")
                sistema.pausar_tecla()
                continue
            #Valido que el rut este ya registrado
            if not sistema.rut_existe_general(rut_solicitante):
                print("El RUT no existe en el sistema.")
                sistema.pausar_tecla()
                continue
            prestamo = sistema.registrar_prestamo(
                rut_solicitante,
                fecha=date.today().strftime("%d-%m-%Y"),
                descripcion=input("Descripcion: ")
            )
            while True:
                agregar = input("Desea agregar material? (S/N): ").upper()
                if agregar != "S":
                    break

                codigo = sistema.pedir_entero("Codigo Material: ", minimo=1, maximo=99999)
                if sistema.buscar_material_por_codigo(codigo) is None:
                    print("El codigo material no existe.")
                    break
                cantidad = sistema.pedir_entero("Cantidad: ", minimo=1, maximo=sistema.buscar_material_por_codigo(codigo).stock_disponible)
                sistema.agregar_detalle_a_prestamo_objeto(
                    prestamo,codigo_material=codigo, cantidad=cantidad)

            if len(prestamo.detalles) > 0:
                sistema.guardar_prestamo(prestamo)
            else:
                print("No se registro el prestamo porque no tiene materiales.")
            sistema.pausar_tecla()
        elif opc == 5:
            sistema.limpiar_pantalla()
            print("=======================================")
            print("======INGRESO DEVOLUCION=======")
            sistema.registrar_devolucion(
                numero_prestamo=int(input("Numero de prestamo: ")),
                fecha=date.today().strftime("%d-%m-%Y")
            )
            sistema.pausar_tecla()
        elif opc == 6:
            sistema.limpiar_pantalla()
            print("=======================================")
            print("======REPORTE PERSONAS=======")
            print("=======================================")
            print("1. Reporte Alumnos")
            print("2. Reporte Docentes")
            opcp = sistema.pedir_entero("Seleccione una opción: ", minimo=1, maximo=2)
            if opcp == 1:
                sistema.reporte_alumnos()
            else:
                sistema.reporte_docentes()
            sistema.pausar_tecla()
        elif opc == 7:
            sistema.limpiar_pantalla()
            print("=======================================")
            print("======REPORTE PRESTAMOS=======")
            print("=======================================")
            print("1. Reporte Global")
            print("2. Reporte por tipo material")
            print("3. Reporte por persona (RUT Alumno o Docente)")
            opcp = sistema.pedir_entero("Seleccione una opción: ", minimo=1, maximo=3)
            if opcp == 1:
                sistema.reporte_prestamos_global()
            elif opcp == 2:
                print("Indique tipo Material a consultar devolucion:\n1-MATERIAL\n2-HERRAMIENTA\n3-EQUIPO")
                tipo=sistema.pedir_entero("Tipo: ", minimo=1, maximo=3)
                match tipo:
                    case 1:
                        tipo="MATERIAL"
                    case 2:
                        tipo="HERRAMIENTA"
                    case 3:
                        tipo="EQUIPO"
                    case _:
                        tipo="Error en registro"   
                sistema.reporte_prestamos_por_tipo(tipo)
            else:
                rut_prestado=input("RUT solicitante prestamo: ")
                if not sistema.validar_rut_mod11(rut_prestado):
                    print("RUT invalido (modulo 11).")
                    sistema.pausar_tecla()
                    continue
                if not sistema.rut_existe_general(rut_prestado):
                    print("El RUT no existe en el sistema.")
                    sistema.pausar_tecla()
                    continue
                sistema.reporte_prestamos_por_persona(rut_prestado)
            sistema.pausar_tecla()
        elif opc == 8:
            sistema.limpiar_pantalla()
            print("=======================================")
            print("======REPORTE DEVOLUCIONES=======")
            print("=======================================")
            print("1. Reporte Global")
            print("2. Reporte por tipo material")
            print("3. Reporte por persona (RUT Alumno o Docente)")
            opcd = sistema.pedir_entero("Seleccione una opción: ", minimo=1, maximo=3)
            if opcd == 1:
                sistema.reporte_devoluciones_global()
            elif opcd == 2:
                print("Indique tipo Material a consultar devolucion:\n1-MATERIAL\n2-HERRAMIENTA\n3-EQUIPO")
                tipo=sistema.pedir_entero("Tipo: ", minimo=1, maximo=3)
                match tipo:
                    case 1:
                        tipo="MATERIAL"
                    case 2:
                        tipo="HERRAMIENTA"
                    case 3:
                        tipo="EQUIPO"
                    case _:
                        tipo="Error en registro"   
                sistema.reporte_devoluciones_por_tipo(tipo)
            else:
                rut_prestado=input("RUT solicitante prestamo: ")
                if not sistema.validar_rut_mod11(rut_prestado):
                    print("RUT invalido (modulo 11).")
                    sistema.pausar_tecla()
                    continue
                if not sistema.rut_existe_general(rut_prestado):
                    print("El RUT no existe en el sistema.")
                    sistema.pausar_tecla()
                    continue
                sistema.reporte_devoluciones_por_persona(rut_prestado)
            sistema.pausar_tecla()
        elif opc == 9:
            sistema.limpiar_pantalla()
            print("=======================================")
            print("======REPORTE MATERIALES=======")
            print("=======================================")
            print("1. Reporte Global")
            print("2. Reporte por tipo")
            opcm = sistema.pedir_entero("Seleccione una opción: ", minimo=1, maximo=2)
            if opcm == 1:
                sistema.reporte_materiales_global()
            else:
                print("Indique tipo Material a consultar:\n1-MATERIAL\n2-HERRAMIENTA\n3-EQUIPO")
                tipo=sistema.pedir_entero("Tipo: ", minimo=1, maximo=3)
                match tipo:
                    case 1:
                        tipo="MATERIAL"
                    case 2:
                        tipo="HERRAMIENTA"
                    case 3:
                        tipo="EQUIPO"
                    case _:
                        tipo="Error en registro"   
                sistema.reporte_materiales_por_tipo(tipo)
            sistema.pausar_tecla()
        elif opc == 10:
            sistema.limpiar_pantalla()
            sistema.pausar_tecla()
            print("Saliendo del sistema...")
            break

if __name__ == "__main__":
    menu()