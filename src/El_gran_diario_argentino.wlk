class Mes {
	var diarios = []
	var costosFijos
	
	constructor(_costos) {
		costosFijos = _costos
	}
	
	method agregarDiario(diario) {
		diarios.add(diario)
	}
	
	method mejorDia() {
		return (diarios.max({ejemplar => ejemplar.saldoDiario()})).nombreDia()
	}
	
	method buscarProduccion(persona) {
		var listasNotas
		listasNotas = diarios.map({ejemplar => ejemplar.notasPublicadas()})
		return listasNotas.any({lista => (lista.map({nota => nota.nombre()})).contains (persona)})	
	}
	
	method cantVecesPublicada(publicidad) {
		return diarios.sum({ejemplar => ejemplar.cantidadVecesPublicada(publicidad)})
	}
	
	method saldoFinal() {
		return diarios.sum({ejemplar => ejemplar.saldoDiario()}) - costosFijos
	}
	
	
}

class Diario {
	var dia
	var paginas
	var tirada
	var precio
	var noVendidos
	var notas = []
	var publicidades = []
	var fotos = []
	
	constructor(_dia,_paginas, _tirada, _precio) {
		dia = _dia
		paginas = _paginas
		tirada = _tirada
		precio = _precio
	}
	
	method noSeVendieron(cant) {
		noVendidos = cant
	}
	
	method costoImpresion() {
		return paginas * 0.001
	}
	
	method egresosPorTirada() {
		return tirada * self.costoImpresion()
	}
	
	method ingresosPorVentas() {
		return (tirada - noVendidos) * precio
	}
	
	method agregarNota(nota) {
		notas.add(nota)
	}
	
	method notasPublicadas() {
		return notas
	}
	
	method agregarPublicidad(publicidad, veces) {
		veces.times({publicidades.add(publicidad)})
	}
	
	method publicidadesPublicadas() {
		return publicidades
	}
	
	method agregarFoto(foto) {
		fotos.add(foto)
	}
	
	method nombreDia() {
		return dia
	}
	
	method ingresosPorPublicidad() {
		return publicidades.sum({publicidad => publicidad.costo()})
	}
	
	method egresosPorNotas() {
		return notas.sum({nota => nota.costo()})
	}
	
	method egresosPorFotos() {
		return fotos.sum({foto => foto.costo()})
	}
	
	method ingresos() {
		return self.ingresosPorVentas() + self.ingresosPorPublicidad() 
	}
	
	method egresos() {
		return self.egresosPorTirada() + self.egresosPorNotas() + self.egresosPorFotos()
	}
	
	method saldoDiario() {
		return self.ingresos() - self.egresos()
	}
	
	method publicidadesOcupan() {
		return publicidades.sum({publicidad => publicidad.ocupa()})
	}
	
	method notasOcupan() {
		return notas.sum({nota => nota.ocupa()})
	}
	
	method promedioCmOcupadosPorPagina(){
		return (self.publicidadesOcupan() + self.notasOcupan()) / paginas
	}
	
	method cantidadVecesPublicada(publicidad) {
		return (publicidades.filter({x => x  == publicidad})).size()
	}
}


class ElementosDiario {
	var nombreAutor
	var tamanio // Medida segun cada elemento
	
	constructor(_nombre, _tamanio) {
		nombreAutor = _nombre
		tamanio = _tamanio
	}
	
	method nombre() {
		return nombreAutor
	}
	
	method ocupa() {
		return tamanio
	}
}


class Nota inherits ElementosDiario {
	constructor(_nombreAutor, _cantCaracteres) = super(_nombreAutor, _cantCaracteres)
	
	override method ocupa() {
		return tamanio / 20
	}
}


class NotaPeriodista inherits Nota {	
	constructor(_cantCaracteres, _nombrePeriodista) = super(_nombrePeriodista, _cantCaracteres)
	
	method costo() {
		return (tamanio * 50) / 1000
	}	
}


class NotaEscritor inherits Nota {
	constructor(_cantCaracteres, _nombreEscritor) = super(_nombreEscritor, _cantCaracteres)
	
	method costo() {
		return (tamanio * 100) / 1000
	}
}


class NotaCelebridad inherits Nota {	
	constructor(_cantCaracteres, _nombreCelebridad) = super(_nombreCelebridad, _cantCaracteres)
	
	method costo() {
		return (tamanio * 500) / 1000
	}
}


class NotaColaborador inherits Nota {	
	constructor(_cantCaracteres, _nombreColaborador) = super(_nombreColaborador, _cantCaracteres)
	
	method costo() {
		return (tamanio * 25) / 1000
	}
}

class NotaLocal inherits Nota {
	var precio
	
	constructor(_cantCaracteres, _nombreMedio, _precio) = super(_nombreMedio, _cantCaracteres) {
		precio = _precio
	}
	
	method costo() {
		return precio
	}
}

class NotaExtranjera inherits NotaLocal {
	var importeFijo
	
	constructor(_cantCaracteres, _nombreMedio, _precio, _importe) = super( _cantCaracteres, _nombreMedio, _precio) {
		importeFijo = _importe
	}
	
	override method costo() {
		return precio + importeFijo
	}
}

class Publicidad inherits ElementosDiario {
	var cliente
	var valorXCm
	
	constructor(_nombreCreativo, _cliente, _valor, _largo) = super(_nombreCreativo, _largo) {
		cliente = _cliente
		valorXCm = _valor
	}
	
	method costo() {
		return valorXCm * tamanio
	}
}

class Foto inherits ElementosDiario {	
	constructor(_fotografo, _tamanio) = super(_fotografo, _tamanio)
	
	method costo() {
		if (tamanio > 75)
			return 200
		return 50
	}	
}

/* 
El motivo de uso de herencia y super es la posibilidad de simplificar y evitar repeticiones en código.
Para este caso todos los elementos que conforman un ejemplar de un diario (Notas, Publicidades y fotografías) comparten la varible nombre de autor y tamaño (esta variable con la respectiva unidad ya sean caracteres o cm).

Los conceptos que se utlizan son principalmente polimorfismo y herencia.  

 */
