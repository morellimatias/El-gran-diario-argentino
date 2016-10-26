class Diario {
	var paginas
	var tirada
	var precio
	var noVendidos
	
	constructor(_paginas, _tirada, _precio) {
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
	
	method ingresoPorVentas() {
		return (tirada - noVendidos) * precio
	}
}


class Nota {
	var cantCaracteres
}
