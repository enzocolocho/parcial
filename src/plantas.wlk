import parcelas.*

class Plantas {
	const property anioObtencionSemilla
	var property altura
	
	method horasDeSolTolerables() 
	
	method esFuerte() = self.horasDeSolTolerables() > 10
	
	method daNuevasSemillas() = self.esFuerte()
	
	method espacioQueOcupa()
	
	method laParcelaEsIdeal(parcela)
	
	method puedeAsociar(parcela){
		var resultado 
		if (parcela.esEcologica()){
			resultado = not(parcela.tieneComplicaciones()) and self.laParcelaEsIdeal(parcela)
		} else if (parcela.esIndustrial()){
			resultado = parcela.plantasQueTiene().size() < 2 and self.esFuerte()
		}
		return resultado
	} 
	
}

class Menta inherits Plantas {
	
	override method horasDeSolTolerables() = 6
	
	override method daNuevasSemillas() = super() or altura > 0.4
	
	override method espacioQueOcupa() = altura * 3
	
	override method laParcelaEsIdeal(parcela) = parcela.superficie() > 6
	
}

class Soja inherits Plantas {
	
	override method horasDeSolTolerables(){
		var resultado = 0
		if (altura < 0.5){
			resultado = 6
		} else if (altura >= 0.5 and altura <= 1){
			resultado = 7
		} else {
			resultado = 9
		}
		return resultado
	}
	
	override method daNuevasSemillas() = super() or (anioObtencionSemilla >= 2007 and altura > 1)
	
	override method espacioQueOcupa() = altura / 2
	
	override method laParcelaEsIdeal(parcela){
		return (parcela.horasDeSolDiarias() == self.horasDeSolTolerables())
	}
	
}

class Quinoa inherits Plantas {
		
	const horasDeSolTolerables
		
	override method horasDeSolTolerables()= horasDeSolTolerables
		
	override method daNuevasSemillas() = super() or anioObtencionSemilla < 2005
	
	override method espacioQueOcupa() = 0.5
	
	override method laParcelaEsIdeal(parcela){ parcela.plantasQueTiene().all({ c => c.altura() < 1.5 }) }
	
}

class SojaTransgenica inherits Soja {
	override method daNuevasSemillas() = false	
	
	override method laParcelaEsIdeal(parcela){
		return  (parcela.cantidadMaximaDePlantas() == 1)
	}
}

class Hierbabuena inherits Menta {
	override method espacioQueOcupa() = super() * 2
}