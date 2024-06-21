class Nave {

	var velocidad = 0
	var direccionRespectoAlSol
	var combustible = 0

	method cargarCombustible(cant) {
		combustible += cant
	}
	method direccionRespectoAlSol(){
		return direccionRespectoAlSol
	}
	method descargarCombustible(cant) {
		combustible -= cant
	}

	method acelerar(cuanto) {
		velocidad += 100000.min(velocidad + cuanto)
	}

	method desacelerar(cuanto) {
		velocidad -= 0.max(velocidad - cuanto)
	}

	method irHaciaElSol() {
		direccionRespectoAlSol = 10
	}

	method escaparDelSol() {
		direccionRespectoAlSol = -10
	}

	method ponerseParaleloAlSol() {
		direccionRespectoAlSol = 0
	}

	method acercarceUnPocoAlSol() {
		direccionRespectoAlSol += 1
	}

	method alejarceUnPocoDelSol() {
		direccionRespectoAlSol -= 1
	}

	method prepararViaje() {
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}
	method estaTranquila(){
		return combustible >= 4000 and velocidad <= 12000
	}
	method estaRelajo(){
		return self.estaTranquila()
	}
}

class NavesBaliza inherits Nave {

	var colorBaliza = ""

	method mostrarBaliza() {
		return colorBaliza
	}

	method cambiarColorBaliza(colorNuevo) {
		colorBaliza = colorNuevo
	}

	override method prepararViaje() {
		super()
		colorBaliza = "verde"
		self.ponerseParaleloAlSol()
	}
	override method estaTranquila(){
		return super() and colorBaliza != "rojo" 
	}
	method recibirAmenaza(){
		self.irHaciaElSol()
		self.cambiarColorBaliza("rojo")
	}
	override method estaRelajo(){
		return super() and colorBaliza == ""
	}
}

class NavesPasajeros inherits Nave {

	var cantPasajeros
	var property racionesComida = 0
	var property racionesBebida = 0

	method cargarComida(cantComida) {
		racionesComida += cantComida
	}

	method cargarBebida(cantBebida) {
		racionesBebida += cantBebida
	}

	method descargarComida(cantComida) {
		racionesComida -= cantComida
	}

	method descargarBebida(cantBebida) {
		racionesBebida -= cantBebida
	}

	override method prepararViaje() {
		super()
		self.cargarComida(4 * cantPasajeros)
		self.cargarBebida(6 * cantPasajeros)
		self.acercarceUnPocoAlSol()
	}
	method recibirAmenaza(){
		self.acelerar(velocidad)
		self.descargarBebida(2 * cantPasajeros)
		self.descargarComida(1 * cantPasajeros)
	}
	override method estaRelajo(){
		return super() and racionesComida < 50
	}
}

class NavesCombate inherits Nave {

	var invisible = false
	var misilesDesplegados = false
	const mensajes = []

	method ponerseVisible() {
		invisible = false
	}

	method ponerseInvisible() {
		invisible = true
	}

	method estaInvisible() {
		return invisible
	}

	method desplegarMisiles() {
		misilesDesplegados = true
	}

	method replegarMisiles() {
		misilesDesplegados = false
	}

	method misilesDesplegados() {
		return misilesDesplegados
	}

	method emitirMensaje(mensaje) {
		mensajes.add(mensaje)
	}

	method mensajesEmitidos() {
		return mensajes.size()
	}

	method primerMensajeEmitido() {
		return mensajes.first()
	}

	method ultimoMensajeEmitido() {
		return mensajes.last()
	}

	method esEscueta() {
		return mensajes.any({ mens => mens.length() > 30 })
	}

	method emitioMensaje(mensaje) {
		return mensajes.contains(mensaje)
	}

	override method prepararViaje() {
		super()
		self.ponerseVisible()
		self.desplegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en misión")
	}
	override method estaTranquila(){
		return super() and !misilesDesplegados
	}
	method recibirAmenaza(){
		self.acercarceUnPocoAlSol()
		self.acercarceUnPocoAlSol()
		self.emitirMensaje("Amenaza recibida")
	}
	override method estaRelajo(){
		return super() and self.esEscueta()
	}
}
class NaveHospital inherits NavesPasajeros{
	var property quirofanosPreparados = false
	method preapararQuirofanos (){
		quirofanosPreparados = true
	}
	override method estaTranquila(){
		return super() and !quirofanosPreparados
	}
	override method recibirAmenaza(){
		super()
		self.preapararQuirofanos()
	}
}
class NaveCombateSigilosa inherits NavesCombate {
	override method estaTranquila(){
		return super() and !invisible
	}
	override method recibirAmenaza(){
		super()
		self.desplegarMisiles()
		self.ponerseInvisible()
	}
}
