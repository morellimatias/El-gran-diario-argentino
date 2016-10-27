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
		return diarios.foldl(0, {cant, ejemplar => cant + ((ejemplar.publicidadesPublicadas()).filter({x => x == publicidad})).size()   })
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
	
	method nombreDia() {
		return dia
	}
	
	method ingresosPorPublicidad() {
		return publicidades.sum({publicidad => publicidad.costo()})
	}
	
	method egresosPorNotas() {
		return notas.sum({nota => nota.costo()})
	}
	
	method ingresos() {
		return self.ingresosPorVentas() + self.ingresosPorPublicidad() 
	}
	
	method egresos() {
		return self.egresosPorTirada() + self.egresosPorNotas()
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
		return publicidades.filter({x => x.nombrePublic() == publicidad})
	}
}


class Nota {
	var cantCaracteres
	
	constructor(_cant) {
		cantCaracteres = _cant
	}
	
	method ocupa() {
		return cantCaracteres / 20
	}
}


class NotaPeriodista inherits Nota {
	var nombrePeriodista
	
	constructor(_cant, _nombre) = super(_cant) {
		nombrePeriodista = _nombre
	}
	
	method costo() {
		return (cantCaracteres * 50) / 1000
	}
	
	method nombre() { 
		return nombrePeriodista
	}	
}


class NotaEscritor inherits Nota {
	var nombreEscritor
	
	constructor(_cant, _nombre) = super(_cant) {
		nombreEscritor = _nombre
	}
	
	method costo() {
		return (cantCaracteres * 100) / 1000
	}
	
	method nombre() { 
		return nombreEscritor
	}	
}


class NotaCelebridad inherits Nota {
	var nombreCelebridad
	
	constructor(_cant, _nombre) = super(_cant) {
		nombreCelebridad = _nombre
	}
	
	method costo() {
		return (cantCaracteres * 500) / 1000
	}
	
	method nombre() { 
		return nombreCelebridad
	}	
}


class NotaColaborador inherits Nota {
	var nombreColaborador
	
	constructor(_cant, _nombre) = super(_cant) {
		nombreColaborador = _nombre
	}
	
	method costo() {
		return (cantCaracteres * 25) / 1000
	}
	
	method nombre() { 
		return nombreColaborador
	}	
}

class NotaLocal inherits Nota {
	var nombreMedio
	var precio
	
	constructor(_cant, _nombre, _precio) = super(_cant) {
		nombreMedio = _nombre
		precio = _precio
	}
	
	method costo() {
		return precio
	}
	
	method nombre() { 
		return nombreMedio
	}	
}

class NotaExtranjera inherits NotaLocal {
	var importeFijo
	
	constructor(_cant, _nombre, _precio, _importe) = super(_cant, _nombre, _precio) {
		importeFijo = _importe
	}
	
	override method costo() {
		return precio + importeFijo
	}
}

class Publicidad {
	var nombreCreativo
	var nombrePublicidad
	var cliente
	var valorXCm
	var largo
	
	constructor(_nombreCreativo, _nombrePublicidad, _cliente, _valor, _largo) {
		nombreCreativo = _nombreCreativo
		nombrePublicidad = _nombrePublicidad
		cliente = _cliente
		valorXCm = _valor
		largo = _largo
	}
	
	method costo() {
		return valorXCm * largo
	}
	
	method ocupa() {
		return largo
	}
	
	method nombre() {
		return nombreCreativo
	}
	
	method nombrePubic() {
		return nombrePublicidad
	}
}

class Foto {
	var fotografo
	var tamanio
	
	constructor(_fotografo, _tamanio) {
		fotografo = _fotografo
		tamanio = _tamanio
	}
	
	method costo() {
		if (tamanio > 75)
			return 200
		return 50
	}
	
	method ocupa() {
		return tamanio
	}
	
	method nombre() {
		return fotografo
	}
	
}
