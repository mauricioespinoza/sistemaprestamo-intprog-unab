from dataclasses import dataclass, field
from typing import List, Optional

'''
Clase persona, alberga atributos comunes para profesor y alumno
'''
@dataclass
class Persona:
    rut: str
    nombre: str
    calle: str
    numero: str
    region: str
    comuna: str
    email: str
    telefono: str

'''
Clase Alumno hija de Persona, alberga atributos solo de alumno
'''
@dataclass
class Alumno(Persona):
    grado: str

'''
Clase Docente hija de Persona, alberga atributos solo de Docente
'''
@dataclass
class Docente(Persona):
    profesion: str
    grado_asignado: str

'''
Clase Material, alberga atributos de materiales
'''
@dataclass
class Material:
    codigo: int
    descripcion: str
    tipo: str
    modelo: str
    serial: str
    costo: int
    stock_total: int
    stock_disponible: int

'''
Clase Detalle Prestamo, alberga atributos del detalle en materiales prestados
'''
@dataclass
class DetallePrestamo:
    codigo_material: int
    cantidad: int
    monto: int
    numero_devolucion: Optional[int] = None
    fecha_devolucion: str = ""

    def esta_devuelto(self) -> bool:
        return self.numero_devolucion is not None
'''
Clase Prestamo, alberga atributos de cacera de prestamo
'''
@dataclass
class Prestamo:
    numero: int
    fecha: str
    rut_solicitante: str
    descripcion: str
    detalles: List[DetallePrestamo] = field(default_factory=list)
'''
Clase Devolucion, alberga atributos de devolucion que se asocia a prestamo
'''
@dataclass
class Devolucion:
    numero: int
    numero_prestamo: int
    fecha: str
    descripcion: str