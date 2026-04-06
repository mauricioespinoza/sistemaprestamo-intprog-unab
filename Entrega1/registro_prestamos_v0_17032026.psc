Algoritmo registro_prestamos
	
	Definir usuario, pass Como Caracter
	Definir OPC Como Entero
	Definir iAlumno, iDocente, iMaterial, iPrestamo, iDevolucion Como Entero
	Definir i Como Entero
	
	// =========================
	// ARREGLOS ALUMNOS
	// =========================
	Dimension rutAlumno[100]
	Dimension nombreAlumno[100]
	Dimension calleAlumno[100]
	Dimension numeroAlumno[100]
	Dimension regionAlumno[100]
	Dimension comunaAlumno[100]
	Dimension emailAlumno[100]
	Dimension telefonoAlumno[100]
	Dimension gradoAlumno[100]
	
	// =========================
	// ARREGLOS DOCENTES
	// =========================
	Dimension rutDocente[100]
	Dimension nombreDocente[100]
	Dimension calleDocente[100]
	Dimension numeroDocente[100]
	Dimension regionDocente[100]
	Dimension comunaDocente[100]
	Dimension emailDocente[100]
	Dimension telefonoDocente[100]
	Dimension profesionDocente[100]
	Dimension gradoAsignadoDocente[100]
	
	// =========================
	// ARREGLOS MATERIALES
	// =========================
	Dimension codigoMaterial[100]
	Dimension descripcionMaterial[100]
	Dimension tipoMaterial[100]
	Dimension modeloMaterial[100]
	Dimension serialMaterial[100]
	Dimension costoMaterial[100]
	Dimension stockTotalMaterial[100]
	Dimension stockDisponibleMaterial[100]
	
	// =========================
	// ARREGLOS PRESTAMOS
	// =========================
	Dimension numeroPrestamo[100]
	Dimension fechaPrestamo[100]
	Dimension rutPrestamo[100]
	Dimension descripcionPrestamo[100]
	Dimension numeroPrestamoDet[500]
	Dimension codigoPrestamoDet[500]
	Dimension cantidadPrestamoDet[500]
	Dimension montoPrestamoDet[500]
	Dimension numeroDevolucionDet[500]
	Dimension fechaDevolucionDet[500]
	Definir iDetallePrestamo Como Entero
	iDetallePrestamo <- 0
	// =========================
	// ARREGLOS DEVOLUCIONES
	// =========================
	Dimension numeroDevolucion[100]
	Dimension numeroPrestamoDev[100]
	Dimension fechaDevolucion[100]
	Dimension descripcionDevolucion[100]
	
	iAlumno <- 0
	iDocente <- 0
	iMaterial <- 0
	iPrestamo <- 0
	iDevolucion <- 0
	
	usuario <- ""
	pass <- ""
	
	// LOGIN
	Mientras usuario <> "admin" O pass <> "admin" Hacer
		Escribir "Ingrese usuario:"
		Leer usuario
		Escribir "Ingrese password:"
		Leer pass
		
		Si usuario <> "admin" O pass <> "admin" Entonces
			Escribir "Credenciales invalidas. Intente nuevamente."
		SiNo
			Escribir "Credenciales correctas."
		FinSi
	FinMientras
	
	Repetir
		Escribir "======================================="
		Escribir " SISTEMA DE PRESTAMOS - ESCUELA"
		Escribir "======================================="
		Escribir "1. Agregar Alumno"
		Escribir "2. Agregar Docente"
		Escribir "3. Registrar Material"
		Escribir "4. Registrar Prestamo"
		Escribir "5. Registrar Devolucion"
		Escribir "6. Reporte Alumnos"
		Escribir "7. Reporte Prestamos"
		Escribir "8. Reporte Materiales"
		Escribir "9. Salir"
		Leer OPC
		
		Si OPC < 1 O OPC > 9 Entonces
			Escribir "Ingrese una opcion valida."
		SiNo
			Segun OPC Hacer
				//Se llaman "metodos" o subprocesos para alinearlo más a un diagrama correcto y a una buena praxis
				1:
					RegistrarAlumno(rutAlumno, nombreAlumno, calleAlumno, numeroAlumno, regionAlumno, comunaAlumno, emailAlumno, telefonoAlumno, gradoAlumno, iAlumno, rutDocente, iDocente)
				2:
					RegistrarDocente(rutDocente, nombreDocente, calleDocente, numeroDocente, regionDocente, comunaDocente, emailDocente, telefonoDocente, profesionDocente, gradoAsignadoDocente, iDocente, rutAlumno, iAlumno)
				3:
					RegistrarMaterial(codigoMaterial, descripcionMaterial, tipoMaterial, modeloMaterial, serialMaterial, costoMaterial, stockTotalMaterial, stockDisponibleMaterial, iMaterial)
				4:
					RegistrarPrestamo(numeroPrestamo, fechaPrestamo, rutPrestamo, descripcionPrestamo, iPrestamo, numeroPrestamoDet, codigoPrestamoDet, cantidadPrestamoDet, montoPrestamoDet, numeroDevolucionDet, fechaDevolucionDet, iDetallePrestamo, codigoMaterial, costoMaterial, stockDisponibleMaterial, iMaterial, rutAlumno, iAlumno, rutDocente, iDocente)
				5:
					RegistrarDevolucion(numeroDevolucion, numeroPrestamoDev, fechaDevolucion, descripcionDevolucion, iDevolucion, numeroPrestamo, iPrestamo, numeroPrestamoDet, codigoPrestamoDet, cantidadPrestamoDet, numeroDevolucionDet, fechaDevolucionDet, iDetallePrestamo, codigoMaterial, stockDisponibleMaterial, iMaterial)
				6:
					ReporteAlumnos(rutAlumno, nombreAlumno, calleAlumno, numeroAlumno, regionAlumno, comunaAlumno, emailAlumno, telefonoAlumno, gradoAlumno, iAlumno)
				7:
					ReportePrestamos(numeroPrestamo, fechaPrestamo, rutPrestamo, descripcionPrestamo, iPrestamo, numeroPrestamoDet, codigoPrestamoDet, cantidadPrestamoDet, montoPrestamoDet, numeroDevolucionDet, fechaDevolucionDet , iDetallePrestamo)
				8:
					ReporteMateriales(codigoMaterial, descripcionMaterial, tipoMaterial, modeloMaterial, serialMaterial, costoMaterial, stockTotalMaterial, stockDisponibleMaterial, iMaterial)
				9:	
					Escribir "Saliendo del sistema..."
			FinSegun
		FinSi
		
	Hasta Que OPC = 9
	
	Escribir "Sistema finalizado."
	
FinAlgoritmo
// =========================================================
// SUBPROCESO REGISTRAR ALUMNO
// =========================================================
SubProceso RegistrarAlumno(rutAlumno Por Referencia, nombreAlumno Por Referencia, calleAlumno Por Referencia, numeroAlumno Por Referencia, regionAlumno Por Referencia, comunaAlumno Por Referencia, emailAlumno Por Referencia, telefonoAlumno Por Referencia, gradoAlumno Por Referencia, iAlumno Por Referencia, rutDocente Por Referencia, iDocente Por Valor)
	
	Definir rutIngresado Como Caracter
	Definir valido, existe Como Logico
	
	Si iAlumno >= 100 Entonces
		Escribir "No hay mas espacio para alumnos."
	SiNo
		Repetir
			Escribir "Ingrese RUT alumno (sin puntos, con guion. Ej: 12345678-5):"
			Leer rutIngresado
			valido <- ValidarRutMod11(rutIngresado)
			existe <- RutExisteGeneral(rutIngresado, rutAlumno, iAlumno, rutDocente, iDocente)
			
			Si No valido Entonces
				Escribir "RUT invalido por modulo 11."
			SiNo
				Si existe Entonces
					Escribir "El RUT ya existe en el sistema."
				FinSi
			FinSi
		Hasta Que valido Y No existe
		
		iAlumno <- iAlumno + 1
		rutAlumno[iAlumno] <- rutIngresado
		
		Escribir "Nombre alumno:"
		Leer nombreAlumno[iAlumno]
		Escribir "Calle:"
		Leer calleAlumno[iAlumno]
		Escribir "Numero:"
		Leer numeroAlumno[iAlumno]
		Escribir "Region:"
		Leer regionAlumno[iAlumno]
		Escribir "Comuna:"
		Leer comunaAlumno[iAlumno]
		Escribir "Email:"
		Leer emailAlumno[iAlumno]
		Escribir "Telefono:"
		Leer telefonoAlumno[iAlumno]
		Escribir "Grado:"
		Leer gradoAlumno[iAlumno]
		Escribir "Alumno registrado correctamente."
	FinSi
	
FinSubProceso
// =========================================================
// SUBPROCESO REGISTRAR DOCENTE
// =========================================================
SubProceso RegistrarDocente(rutDocente Por Referencia, nombreDocente Por Referencia, calleDocente Por Referencia, numeroDocente Por Referencia, regionDocente Por Referencia, comunaDocente Por Referencia, emailDocente Por Referencia, telefonoDocente Por Referencia, profesionDocente Por Referencia, gradoAsignadoDocente Por Referencia, iDocente Por Referencia, rutAlumno Por Referencia, iAlumno Por Valor)
	Definir rutIngresado Como Caracter
	Definir valido, existe Como Logico
	
	Si iDocente >= 100 Entonces
		Escribir "No hay mas espacio para docentes."
	SiNo
		Repetir
			Escribir "Ingrese RUT docente (sin puntos, con guion. Ej: 12345678-5):"
			Leer rutIngresado
			valido <- ValidarRutMod11(rutIngresado)
			existe <- RutExisteGeneral(rutIngresado, rutAlumno, iAlumno, rutDocente, iDocente)
			Si No valido Entonces
				Escribir "RUT invalido por modulo 11."
			SiNo
				Si existe Entonces
					Escribir "El RUT ya existe en el sistema."
				FinSi
			FinSi
		Hasta Que valido Y No existe

		iDocente <- iDocente + 1
		rutDocente[iDocente] <- rutIngresado
		Escribir "Nombre docente:"
		Leer nombreDocente[iDocente]
		Escribir "Calle:"
		Leer calleDocente[iDocente]
		Escribir "Numero:"
		Leer numeroDocente[iDocente]
		Escribir "Region:"
		Leer regionDocente[iDocente]
		Escribir "Comuna:"
		Leer comunaDocente[iDocente]
		Escribir "Email:"
		Leer emailDocente[iDocente]
		Escribir "Telefono:"
		Leer telefonoDocente[iDocente]
		Escribir "Profesion:"
		Leer profesionDocente[iDocente]
		Escribir "Grado asignado:"
		Leer gradoAsignadoDocente[iDocente]
		Escribir "Docente registrado correctamente."
	FinSi
FinSubProceso
// =========================================================
// SUBPROCESO REGISTRAR MATERIAL
// =========================================================
SubProceso RegistrarMaterial(codigoMaterial Por Referencia, descripcionMaterial Por Referencia, tipoMaterial Por Referencia, modeloMaterial Por Referencia, serialMaterial Por Referencia, costoMaterial Por Referencia, stockTotalMaterial Por Referencia, stockDisponibleMaterial Por Referencia, iMaterial Por Referencia)
	Definir codigoIngresado, tipoIngresado Como Caracter
	Definir costoIngresado Como Entero
	Definir existe, tipoValido, costoValido Como Logico
	Definir costoTexto Como Caracter
	
	Si iMaterial >= 100 Entonces
		Escribir "No hay mas espacio para materiales."
	SiNo
		Repetir
			Escribir "Codigo material:"
			Leer codigoIngresado
			
			existe <- CodigoMaterialExiste(codigoIngresado, codigoMaterial, iMaterial)
			
			Si existe Entonces
				Escribir "El codigo de material ya existe en el sistema."
			FinSi
		Hasta Que No existe
		
		iMaterial <- iMaterial + 1
		codigoMaterial[iMaterial] <- codigoIngresado
		
		Escribir "Descripcion:"
		Leer descripcionMaterial[iMaterial]
		
		Repetir
			Escribir "Tipo (MATERIAL / HERRAMIENTA / EQUIPO):"
			Leer tipoIngresado
			tipoIngresado <- Mayusculas(tipoIngresado)
			
			tipoValido <- Falso
			
			Si tipoIngresado = "MATERIAL" O tipoIngresado = "HERRAMIENTA" O tipoIngresado = "EQUIPO" Entonces
				tipoValido <- Verdadero
			SiNo
				Escribir "Tipo invalido. Solo puede ser MATERIAL, HERRAMIENTA o EQUIPO."
			FinSi
		Hasta Que tipoValido
		
		tipoMaterial[iMaterial] <- tipoIngresado
		
		Escribir "Modelo:"
		Leer modeloMaterial[iMaterial]
		
		Escribir "Serial:"
		Leer serialMaterial[iMaterial]
		
		Repetir
			Escribir "Costo (solo numeros enteros):"
			Leer costoTexto
			costoValido <- EsNumeroEntero(costoTexto)
			
			Si costoValido Entonces
				costoIngresado <- ConvertirANumero(costoTexto)
				
				Si costoIngresado < 0 Entonces
					Escribir "El costo no puede ser negativo."
					costoValido <- Falso
				FinSi
			SiNo
				Escribir "Debe ingresar solo numeros enteros."
			FinSi
		Hasta Que costoValido
		costoMaterial[iMaterial] <- costoIngresado
		
		Repetir
			Escribir "Stock total:"
			Leer stockTotalMaterial[iMaterial]
			
			Si stockTotalMaterial[iMaterial] <= 0 Entonces
				Escribir "El stock debe ser mayor que 0."
			FinSi
		Hasta Que stockTotalMaterial[iMaterial] > 0
		
		stockDisponibleMaterial[iMaterial] <- stockTotalMaterial[iMaterial]
		
		Escribir "Material registrado correctamente."
		Escribir "Stock disponible inicial: ", stockDisponibleMaterial[iMaterial]
	FinSi
FinSubProceso
// =========================================================
// SUBPROCESO REGISTRAR PRESTAMO
// =========================================================
SubProceso RegistrarPrestamo(numeroPrestamo Por Referencia, fechaPrestamo Por Referencia, rutPrestamo Por Referencia, descripcionPrestamo Por Referencia, iPrestamo Por Referencia, numeroPrestamoDet Por Referencia, codigoPrestamoDet Por Referencia, cantidadPrestamoDet Por Referencia, montoPrestamoDet Por Referencia, numeroDevolucionDet Por Referencia, fechaDevolucionDet Por Referencia, iDetallePrestamo Por Referencia, codigoMaterial Por Referencia, costoMaterial Por Referencia, stockDisponibleMaterial Por Referencia, iMaterial Por Valor, rutAlumno Por Referencia, iAlumno Por Valor, rutDocente Por Referencia, iDocente Por Valor)
	
	Definir rutBuscado, codigoBuscado, respuesta Como Caracter
	Definir existeRut, existeMaterial, yaAgregado Como Logico
	Definir cantidadSolicitada, posMaterial Como Entero
	
	Si iPrestamo >= 100 Entonces
		Escribir "No hay mas espacio para prestamos."
	SiNo
		Repetir
			Escribir "RUT solicitante:"
			Leer rutBuscado
			existeRut <- RutExisteGeneral(rutBuscado, rutAlumno, iAlumno, rutDocente, iDocente)
			
			Si No existeRut Entonces
				Escribir "El RUT no existe en alumnos ni docentes."
			FinSi
		Hasta Que existeRut
		
		iPrestamo <- iPrestamo + 1
		numeroPrestamo[iPrestamo] <- iPrestamo
		
		Escribir "Numero de prestamo asignado: ", numeroPrestamo[iPrestamo]
		
		Escribir "Fecha del prestamo:"
		Leer fechaPrestamo[iPrestamo]
		
		rutPrestamo[iPrestamo] <- rutBuscado
		
		Escribir "Descripcion del prestamo:"
		Leer descripcionPrestamo[iPrestamo]
		
		respuesta <- "S"
		
		Mientras respuesta = "S" O respuesta = "s" Hacer
			
			Repetir
				Escribir "Codigo del material:"
				Leer codigoBuscado
				
				existeMaterial <- ExisteCodigoMaterial(codigoBuscado, codigoMaterial, iMaterial)
				
				Si No existeMaterial Entonces
					Escribir "El codigo material no existe."
				FinSi
			Hasta Que existeMaterial
			
			posMaterial <- BuscarPosicionMaterial(codigoBuscado, codigoMaterial, iMaterial)
			
			yaAgregado <- MaterialYaEnPrestamo(numeroPrestamo[iPrestamo], codigoBuscado, numeroPrestamoDet, codigoPrestamoDet, iDetallePrestamo)
			
			Si yaAgregado Entonces
				Escribir "Ese material ya fue agregado a este prestamo."
			SiNo
				Escribir "Stock disponible: ", stockDisponibleMaterial[posMaterial]
				
				Repetir
					Escribir "Cantidad a prestar:"
					Leer cantidadSolicitada
					
					Si cantidadSolicitada <= 0 Entonces
						Escribir "La cantidad debe ser mayor que 0."
					SiNo
						Si cantidadSolicitada > stockDisponibleMaterial[posMaterial] Entonces
							Escribir "No hay stock suficiente."
						FinSi
					FinSi
				Hasta Que cantidadSolicitada > 0 Y cantidadSolicitada <= stockDisponibleMaterial[posMaterial]
				
				iDetallePrestamo <- iDetallePrestamo + 1
				numeroPrestamoDet[iDetallePrestamo] <- numeroPrestamo[iPrestamo]
				codigoPrestamoDet[iDetallePrestamo] <- codigoBuscado
				cantidadPrestamoDet[iDetallePrestamo] <- cantidadSolicitada
				montoPrestamoDet[iDetallePrestamo] <- costoMaterial[posMaterial] * cantidadSolicitada
				numeroDevolucionDet[iDetallePrestamo] <- 0
				fechaDevolucionDet[iDetallePrestamo] <- ""
				
				stockDisponibleMaterial[posMaterial] <- stockDisponibleMaterial[posMaterial] - cantidadSolicitada
				
				Escribir "Material agregado al prestamo."
				Escribir "Nuevo stock disponible: ", stockDisponibleMaterial[posMaterial]
			FinSi
			
			Escribir "Desea agregar otro material? (S/N)"
			Leer respuesta
			
		FinMientras
		
		Escribir "Prestamo registrado correctamente."
	FinSi
FinSubProceso

Funcion pos <- BuscarPosicionMaterial(codigoBuscado, codigoMaterial, iMaterial)
	Definir pos, i Como Entero
	
	pos <- -1
	
	Si iMaterial > 0 Entonces
		Para i <- 1 Hasta iMaterial Hacer
			Si codigoMaterial[i] = codigoBuscado Entonces
				pos <- i
			FinSi
		FinPara
	FinSi
FinFuncion
Funcion existe <- MaterialYaEnPrestamo(numeroBuscado, codigoBuscado, numeroPrestamoDet, codigoPrestamoDet, iDetallePrestamo)
	Definir existe Como Logico
	Definir i Como Entero
	
	existe <- Falso
	
	Si iDetallePrestamo > 0 Entonces
		Para i <- 1 Hasta iDetallePrestamo Hacer
			Si numeroPrestamoDet[i] = numeroBuscado Y codigoPrestamoDet[i] = codigoBuscado Entonces
				existe <- Verdadero
			FinSi
		FinPara
	FinSi
FinFuncion
// =========================================================
// SUBPROCESO REGISTRAR DEVOLUCION
// =========================================================
SubProceso RegistrarDevolucion(numeroDevolucion Por Referencia, numeroPrestamoDev Por Referencia, fechaDevolucion Por Referencia, descripcionDevolucion Por Referencia, iDevolucion Por Referencia, numeroPrestamo Por Referencia, iPrestamo Por Valor, numeroPrestamoDet Por Referencia, codigoPrestamoDet Por Referencia, cantidadPrestamoDet Por Referencia, numeroDevolucionDet Por Referencia, fechaDevolucionDet Por Referencia, iDetallePrestamo Por Valor, codigoMaterial Por Referencia, stockDisponibleMaterial Por Referencia, iMaterial Por Valor)
	
	Definir prestamoTexto Como Caracter
	Definir numeroPrestamoBuscado Como Entero
	Definir prestamoValido, existePrestamo, yaDevuelto Como Logico
	Definir i, posMaterial Como Entero
	
	Si iDevolucion >= 100 Entonces
		Escribir "No hay mas espacio para devoluciones."
	SiNo
		
		Repetir
			Escribir "Numero de prestamo asociado:"
			Leer prestamoTexto
			
			prestamoValido <- EsNumeroEntero(prestamoTexto)
			
			Si prestamoValido Entonces
				numeroPrestamoBuscado <- ConvertirANumero(prestamoTexto)
				existePrestamo <- ExisteNumeroPrestamo(numeroPrestamoBuscado, numeroPrestamo, iPrestamo)
				
				Si existePrestamo Entonces
					yaDevuelto <- PrestamoYaDevuelto(numeroPrestamoBuscado, numeroPrestamoDev, iDevolucion)
					
					Si yaDevuelto Entonces
						Escribir "Ese prestamo ya fue devuelto."
						prestamoValido <- Falso
					FinSi
				SiNo
					Escribir "El numero de prestamo no existe."
					prestamoValido <- Falso
				FinSi
			SiNo
				Escribir "Debe ingresar un numero de prestamo valido."
			FinSi
		Hasta Que prestamoValido
		
		iDevolucion <- iDevolucion + 1
		numeroDevolucion[iDevolucion] <- iDevolucion
		numeroPrestamoDev[iDevolucion] <- numeroPrestamoBuscado
		
		Escribir "Numero de devolucion asignado: ", numeroDevolucion[iDevolucion]
		
		Escribir "Fecha devolución:"
		Leer fechaDevolucion[iDevolucion]
		
		Escribir "Descripcion devolución:"
		Leer descripcionDevolucion[iDevolucion]
		
		// ?? CIERRE DEL PRESTAMO + REPOSICION STOCK
		Para i <- 1 Hasta iDetallePrestamo Hacer
			
			Si numeroPrestamoDet[i] = numeroPrestamoBuscado Entonces
				
				// Solo si no estaba devuelto (extra seguridad)
				Si numeroDevolucionDet[i] = 0 Entonces
					
					posMaterial <- BuscarPosicionMaterial(codigoPrestamoDet[i], codigoMaterial, iMaterial)
					
					Si posMaterial <> -1 Entonces
						stockDisponibleMaterial[posMaterial] <- stockDisponibleMaterial[posMaterial] + cantidadPrestamoDet[i]
					FinSi
					
					// ?? MARCAR COMO DEVUELTO
					numeroDevolucionDet[i] <- numeroDevolucion[iDevolucion]
					fechaDevolucionDet[i] <- fechaDevolucion[iDevolucion]
					
				FinSi
				
			FinSi
			
		FinPara
		
		Escribir "Devolucion registrada correctamente."
	FinSi
	
FinSubProceso
Funcion existe <- PrestamoYaDevuelto(numeroBuscado, numeroPrestamoDev, iDevolucion)
	Definir existe Como Logico
	Definir i Como Entero
	
	existe <- Falso
	
	Si iDevolucion > 0 Entonces
		Para i <- 1 Hasta iDevolucion Hacer
			Si numeroPrestamoDev[i] = numeroBuscado Entonces
				existe <- Verdadero
			FinSi
		FinPara
	FinSi
FinFuncion

// =========================================================
// REPORTE ALUMNOS
// =========================================================
SubProceso ReporteAlumnos(rutAlumno Por Referencia, nombreAlumno Por Referencia, calleAlumno Por Referencia, numeroAlumno Por Referencia, regionAlumno Por Referencia, comunaAlumno Por Referencia, emailAlumno Por Referencia, telefonoAlumno Por Referencia, gradoAlumno Por Referencia, iAlumno Por Valor)
	
	Definir i Como Entero
	
	Si iAlumno = 0 Entonces
		Escribir "No hay alumnos registrados."
	SiNo
		Escribir "=========== REPORTE ALUMNOS ==========="
		Para i <- 1 Hasta iAlumno Hacer
			Escribir "Alumno N° ", i
			Escribir "RUT: ", rutAlumno[i]
			Escribir "Nombre: ", nombreAlumno[i]
			Escribir "Direccion: ", calleAlumno[i], ' ', numeroAlumno[i]
			Escribir "Region: ", regionAlumno[i]
			Escribir "Comuna: ", comunaAlumno[i]
			Escribir "Email: ", emailAlumno[i]
			Escribir "Telefono: ", telefonoAlumno[i]
			Escribir "Grado: ", gradoAlumno[i]
			Escribir "---------------------------------------"
		FinPara
	FinSi
	
FinSubProceso

// =========================================================
// REPORTE PRESTAMOS
// =========================================================
SubProceso ReportePrestamos(numeroPrestamo Por Referencia, fechaPrestamo Por Referencia, rutPrestamo Por Referencia, descripcionPrestamo Por Referencia, iPrestamo Por Valor, numeroPrestamoDet Por Referencia, codigoPrestamoDet Por Referencia, cantidadPrestamoDet Por Referencia, montoPrestamoDet Por Referencia, numeroDevolucionDet Por Referencia, fechaDevolucionDet Por Referencia, iDetallePrestamo Por Valor)
	
	Definir i, j Como Entero
	
	Si iPrestamo = 0 Entonces
		Escribir "No hay prestamos registrados."
	SiNo
		Escribir "========== REPORTE PRESTAMOS =========="
		
		Para i <- 1 Hasta iPrestamo Hacer
			Escribir "Prestamo N° ", i
			Escribir "Numero prestamo: ", numeroPrestamo[i]
			Escribir "Fecha: ", fechaPrestamo[i]
			Escribir "RUT solicitante: ", rutPrestamo[i]
			Escribir "Descripcion: ", descripcionPrestamo[i]
			Escribir "Detalle:"
			
			Para j <- 1 Hasta iDetallePrestamo Hacer
				Si numeroPrestamoDet[j] = numeroPrestamo[i] Entonces
					Escribir "  Codigo: ", codigoPrestamoDet[j], " | Cantidad: ", cantidadPrestamoDet[j], " | Monto: ", montoPrestamoDet[j]
					
					Si numeroDevolucionDet[j] = 0 Entonces
						Escribir "  Estado: PENDIENTE DEVOLUCION"
					SiNo
						Escribir "  Estado: DEVUELTO | N° devolucion: ", numeroDevolucionDet[j], " | Fecha devolucion: ", fechaDevolucionDet[j]
					FinSi
				FinSi
			FinPara
			
			Escribir "---------------------------------------"
		FinPara
	FinSi
	
FinSubProceso
// =========================================================
// REPORTE MATERIALES
// =========================================================
SubProceso ReporteMateriales(codigoMaterial Por Referencia, descripcionMaterial Por Referencia, tipoMaterial Por Referencia, modeloMaterial Por Referencia, serialMaterial Por Referencia, costoMaterial Por Referencia, stockTotalMaterial Por Referencia, stockDisponibleMaterial Por Referencia, iMaterial Por Valor)
	
	Definir i Como Entero
	
	Si iMaterial = 0 Entonces
		Escribir "No hay materiales registrados."
	SiNo
		Escribir "========= REPORTE DE MATERIALES ========="
		
		Para i <- 1 Hasta iMaterial Hacer
			Escribir "Material N° ", i
			Escribir "Codigo: ", codigoMaterial[i]
			Escribir "Descripcion: ", descripcionMaterial[i]
			Escribir "Tipo: ", tipoMaterial[i]
			Escribir "Modelo: ", modeloMaterial[i]
			Escribir "Serial: ", serialMaterial[i]
			Escribir "Costo: ", costoMaterial[i]
			Escribir "Stock total: ", stockTotalMaterial[i]
			Escribir "Stock disponible: ", stockDisponibleMaterial[i]
			Escribir "Valor Total Material ", i, " código: ", codigoMaterial[i], ": ", (costoMaterial[i] * stockTotalMaterial[i])
			Escribir "Valor Disponible Material ", i, " código: ", codigoMaterial[i], ": ",(costoMaterial[i] * stockDisponibleMaterial[i])
			Escribir "-----------------------------------------"
		FinPara
	FinSi
	
FinSubProceso

// =========================================================
// FUNCION: EXISTE CODIGO MATERIAL
// =========================================================
Funcion existe <- ExisteCodigoMaterial(codigoBuscado, codigoMaterial Por Referencia, iMaterial Por Valor)
	Definir existe Como Logico
	Definir i Como Entero
	
	existe <- Falso
	
	Para i <- 1 Hasta iMaterial Hacer
		Si codigoMaterial[i] = codigoBuscado Entonces
			existe <- Verdadero
		FinSi
	FinPara
	
FinFuncion


// =========================================================
// FUNCION: EXISTE NUMERO PRESTAMO
// =========================================================
Funcion existe <- ExisteNumeroPrestamo(prestamoBuscado, numeroPrestamo Por Referencia, iPrestamo Por Valor)
	Definir existe Como Logico
	Definir i Como Entero
	
	existe <- Falso
	
	Para i <- 1 Hasta iPrestamo Hacer
		Si numeroPrestamo[i] = prestamoBuscado Entonces
			existe <- Verdadero
		FinSi
	FinPara
	
FinFuncion

// =========================================================
// FUNCION: RUT YA EXISTE EN ALUMNOS O DOCENTES
// =========================================================
Funcion existe <- RutExisteGeneral(rutBuscado, rutAlumno Por Referencia, iAlumno Por Valor, rutDocente Por Referencia, iDocente Por Valor)
	Definir existe Como Logico
	Definir i Como Entero
	
	existe <- Falso
	
	Si iAlumno > 0 Entonces
		Para i <- 1 Hasta iAlumno Hacer
			Si rutAlumno[i] = rutBuscado Entonces
				existe <- Verdadero
			FinSi
		FinPara
	FinSi
	
	Si iDocente > 0 Entonces
		Para i <- 1 Hasta iDocente Hacer
			Si rutDocente[i] = rutBuscado Entonces
				existe <- Verdadero
			FinSi
		FinPara
	FinSi
	
FinFuncion

// =========================================================
// FUNCION VALIDAR RUT MOD 11
// FORMATO ESPERADO: 12345678-5  o  12345678-K
// =========================================================
Funcion valido <- ValidarRutMod11(rut)
	Definir valido Como Logico
	Definir largo, i, factor, suma, resto, num Como Entero
	Definir cuerpo, dvIngresado, caracter Como Caracter
	Definir soloNumeros Como Logico
	
	valido <- Falso
	soloNumeros <- Verdadero
	suma <- 0
	factor <- 2
	
	largo <- Longitud(rut)
	
	Si largo < 3 Entonces
		valido <- Falso
	SiNo
		Si Subcadena(rut, largo - 1, largo - 1) <> "-" Entonces
			valido <- Falso
		SiNo
			cuerpo <- Subcadena(rut, 1, largo - 2)
			dvIngresado <- Mayusculas(Subcadena(rut, largo, largo))
			Para i <- Longitud(cuerpo)  Hasta 1 Con Paso -1 Hacer
				caracter <- Subcadena(cuerpo, i, i)
				Segun caracter Hacer
					"0":
						num <- 0
					"1":
						num <- 1
					"2":
						num <- 2
					"3":
						num <- 3
					"4":
						num <- 4
					"5":
						num <- 5
					"6":
						num <- 6
					"7":
						num <- 7
					"8":
						num <- 8
					"9":
						num <- 9
					De Otro Modo:
						soloNumeros <- Falso
				FinSegun
				
				Si soloNumeros Entonces
					suma <- suma + num * factor
					factor <- factor + 1
					
					Si factor > 7 Entonces
						factor <- 2
					FinSi
				FinSi
			FinPara
			
			Si soloNumeros Entonces
				resto <- 11 - (suma MOD 11)
				
				Segun resto Hacer
					11:
						Si dvIngresado = "0" Entonces
							valido <- Verdadero
						FinSi
					10:
						Si dvIngresado = "K" Entonces
							valido <- Verdadero
						FinSi
					1:
						Si dvIngresado = "1" Entonces
							valido <- Verdadero
						FinSi
					2:
						Si dvIngresado = "2" Entonces
							valido <- Verdadero
						FinSi
					3:
						Si dvIngresado = "3" Entonces
							valido <- Verdadero
						FinSi
					4:
						Si dvIngresado = "4" Entonces
							valido <- Verdadero
						FinSi
					5:
						Si dvIngresado = "5" Entonces
							valido <- Verdadero
						FinSi
					6:
						Si dvIngresado = "6" Entonces
							valido <- Verdadero
						FinSi
					7:
						Si dvIngresado = "7" Entonces
							valido <- Verdadero
						FinSi
					8:
						Si dvIngresado = "8" Entonces
							valido <- Verdadero
						FinSi
					9:
						Si dvIngresado = "9" Entonces
							valido <- Verdadero
						FinSi
					De Otro Modo:
						valido <- Falso
				FinSegun
			SiNo
				valido <- Falso
			FinSi
		FinSi
	FinSi
FinFuncion
// =========================================================
// FUNCION VALIDAR CÓDIGO MATERIAL DUPLICADO
// =========================================================
Funcion existe <- CodigoMaterialExiste(codigoBuscado, codigoMaterial, iMaterial)
	Definir existe Como Logico
	Definir i Como Entero
	
	existe <- Falso
	
	Si iMaterial > 0 Entonces
		Para i <- 1 Hasta iMaterial Hacer
			Si codigoMaterial[i] = codigoBuscado Entonces
				existe <- Verdadero
			FinSi
		FinPara
	FinSi
FinFuncion
//Valido números enteros
Funcion valido <- EsNumeroEntero(texto)
	Definir valido Como Logico
	Definir i Como Entero
	Definir caracter Como Caracter
	
	valido <- Verdadero
	
	Si Longitud(texto) = 0 Entonces
		valido <- Falso
	SiNo
		Para i <- 1 Hasta Longitud(texto) Hacer
			caracter <- Subcadena(texto, i, i)
			
			Si caracter <> "0" Y caracter <> "1" Y caracter <> "2" Y caracter <> "3" Y caracter <> "4" Y caracter <> "5" Y caracter <> "6" Y caracter <> "7" Y caracter <> "8" Y caracter <> "9" Entonces
				valido <- Falso
			FinSi
		FinPara
	FinSi
FinFuncion