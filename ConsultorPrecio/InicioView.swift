import SwiftUI

struct InicioView: View {

    @Binding var historial: [CalculoGuardado]

    @State private var nombreProducto = ""
    @State private var valorTotal = ""
    @State private var cantidadProductos = ""
    @State private var porcentajeGanancia = ""

    @State private var precioVentaUnidad: Double = 0
    @State private var costoPorUnidad: Double = 0
    @State private var gananciaPorUnidad: Double = 0
    @State private var ivaUnidad: Double = 0
    @State private var precioFinalConIva: Double = 0

    @State private var mostrarResultado = false
    @State private var mostrarError = false
    @State private var mensajeError = ""

    @State private var precioConIva = false

    let porcentajeIVA: Double = 19

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {

                    // HEADER
                    VStack(spacing: 8) {
                        Image(systemName: "calculator.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.blue)

                        Text("Consultor de Precios")
                            .font(.title)
                            .fontWeight(.bold)

                        Text("Calcula el precio de venta por unidad")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.top)

                    // SELECTOR IVA
                    VStack(alignment: .leading, spacing: 12) {
                        Text("¿El precio incluye IVA?")
                            .font(.headline)

                        HStack {
                            Button {
                                precioConIva = false
                            } label: {
                                Text("Sin IVA")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(precioConIva ? .gray.opacity(0.2) : .blue.opacity(0.2))
                                    .foregroundColor(precioConIva ? .gray : .blue)
                                    .cornerRadius(10)
                            }

                            Button {
                                precioConIva = true
                            } label: {
                                Text("Con IVA")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(precioConIva ? .green.opacity(0.2) : .gray.opacity(0.2))
                                    .foregroundColor(precioConIva ? .green : .gray)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding()
                    .background(.gray.opacity(0.05))
                    .cornerRadius(12)

                    // FORMULARIO
                    Group {
                        campo("Valor total", $valorTotal, teclado: .decimalPad)
                        campo("Cantidad de productos", $cantidadProductos, teclado: .numberPad)
                        campo("Porcentaje ganancia", $porcentajeGanancia, teclado: .decimalPad)
                    }

                    // ERROR
                    if mostrarError {
                        Text(mensajeError)
                            .foregroundColor(.red)
                    }

                    // CALCULAR
                    Button("Calcular") {
                        calcular()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)

                    // RESULTADO
                    if mostrarResultado {
                        VStack(spacing: 12) {
                            resultado("Precio sin IVA", precioVentaUnidad, .orange)
                            resultado("IVA", ivaUnidad, .red)
                            resultado("Precio final con IVA", precioFinalConIva, .green)
                        }
                        .padding()
                        .background(.gray.opacity(0.1))
                        .cornerRadius(12)

                        Button("Guardar en historial") {
                            guardar()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.green.opacity(0.2))
                        .cornerRadius(12)
                    }
                }
                .padding()
                
                Text("Desarrollada por Jose")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 30)
            }
            .onTapGesture { ocultarTeclado() }
        }
    }

    // MARK: - COMPONENTES
    func campo(_ titulo: String,
               _ texto: Binding<String>,
               teclado: UIKeyboardType = .default) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(titulo).font(.headline)
            TextField(titulo, text: texto)
                .textFieldStyle(.roundedBorder)
                .keyboardType(teclado)
        }
    }

    func resultado(_ titulo: String, _ valor: Double, _ color: Color) -> some View {
        VStack(alignment: .leading) {
            Text(titulo)
            Text("$\(valor, specifier: "%.2f")")
                .font(.title2)
                .foregroundColor(color)
        }
    }

    // MARK: - LÓGICA
    func calcular() {
        guard
            let total = Double(valorTotal),
            let cantidad = Double(cantidadProductos),
            let ganancia = Double(porcentajeGanancia),
            total > 0, cantidad > 0
        else {
            mostrarError = true
            mensajeError = "Datos inválidos"
            return
        }

        let totalSinIVA: Double

            if precioConIva {
                // 🔥 QUITAMOS EL IVA
                totalSinIVA = total / (1 + porcentajeIVA / 100)
            } else {
                totalSinIVA = total
            }

            costoPorUnidad = totalSinIVA / cantidad
            gananciaPorUnidad = costoPorUnidad * (ganancia / 100)
            precioVentaUnidad = costoPorUnidad + gananciaPorUnidad
            ivaUnidad = precioVentaUnidad * (porcentajeIVA / 100)
            precioFinalConIva = precioVentaUnidad + ivaUnidad

            withAnimation {
                mostrarResultado = true
            }

            ocultarTeclado()
    }

    func guardar() {
        let calculo = CalculoGuardado(
            nombreProducto: nombreProducto,
            valorTotal: valorTotal,
            cantidadProductos: cantidadProductos,
            porcentajeGanancia: porcentajeGanancia,
            precioVentaUnidad: precioVentaUnidad,
            ivaUnidad: ivaUnidad,
            precioFinalConIva: precioFinalConIva,
            precioConIva: precioConIva,
            fecha: Date()
        )

        historial.insert(calculo, at: 0)
        
    }

    func ocultarTeclado() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil
        )
    }
}
