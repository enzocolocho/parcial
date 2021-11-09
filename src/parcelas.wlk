import plantas.*

class Parcela {
	
	const property ancho
	const property largo
	const property horasDeSolDiarias 
	var property plantasQueTiene = []
	const property esEcologica
	const property esIndustrial = not esEcologica
	
	method porcentajeDePlantasBienAsociadas(){
		const cantPlantasBienAsociadas = plantasQueTiene.count({ c => c.puedeAsociar(self)}) 
		return (cantPlantasBienAsociadas / self.cantidadDePlantas())
	}
	
	method superficie() = ancho * largo
	
	method cantidadMaximaDePlantas(){
		var cant
		if(ancho > largo){
			cant = (self.superficie()/5)} 
		else {
			cant = (self.superficie()/3 + largo)}
		return cant
			}
	
	method tieneComplicaciones(){plantasQueTiene.any({c => c.horasDeSolTolerables() < horasDeSolDiarias})}
	
	method plantar(planta){
		if(plantasQueTiene.size() + 1 > self.cantidadMaximaDePlantas() or horasDeSolDiarias - planta.horasDeSolTolerables() >= 2){
			self.error("No se puede plantar.")
		} else {
			plantasQueTiene.add(planta)	
		}
	}
	
	method cantidadDePlantas() = plantasQueTiene.size()
}


object inta {
	var property parcelasQueTiene = []
	
	method cantDeParcelas() = parcelasQueTiene.size()
	
	method cantDePlantas(){ return parcelasQueTiene.sum({ c => c.cantidadDePlantas() })}
	
	method promedioDePlantas() = self.cantDePlantas() / self.cantDeParcelas()
	
	method parcelaMasAutosustentable(){
		const parcelasOptimas = parcelasQueTiene.filter({c => c.cantidadDePlantas() >= 4})
		return (parcelasOptimas.max({c => c.porcentajeDePlantasBienAsociadas( )}))
	}
}