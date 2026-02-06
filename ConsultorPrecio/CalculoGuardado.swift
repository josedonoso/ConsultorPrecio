import Foundation

class CalculoGuardado: Identifiable {
    let id = UUID()
    var nombreProducto: String
    let valorTotal: String
    let cantidadProductos: String
    let porcentajeGanancia: String
    let precioVentaUnidad: Double
    let ivaUnidad: Double
    let precioFinalConIva: Double
    let precioConIva: Bool
    let fecha: Date

    init(
        nombreProducto: String,
        valorTotal: String,
        cantidadProductos: String,
        porcentajeGanancia: String,
        precioVentaUnidad: Double,
        ivaUnidad: Double,
        precioFinalConIva: Double,
        precioConIva: Bool,
        fecha: Date
    ) {
        self.nombreProducto = nombreProducto
        self.valorTotal = valorTotal
        self.cantidadProductos = cantidadProductos
        self.porcentajeGanancia = porcentajeGanancia
        self.precioVentaUnidad = precioVentaUnidad
        self.ivaUnidad = ivaUnidad
        self.precioFinalConIva = precioFinalConIva
        self.precioConIva = precioConIva
        self.fecha = fecha
    }
}
