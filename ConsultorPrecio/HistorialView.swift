import SwiftUI

struct HistorialView: View {

    @Binding var historial: [CalculoGuardado]

    @State private var editandoID: UUID? = nil
    
    let formatterES: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "es_CL") // español Chile
        f.dateFormat = "dd 'de' MMMM 'de' yyyy"
        return f
    }()

    var body: some View {
        NavigationStack {
            List {
                ForEach($historial) { $item in
                    VStack(alignment: .leading, spacing: 8) {

                        HStack {
                            if editandoID == item.id {
                                TextField("Nombre del producto", text: $item.nombreProducto)
                                    .textFieldStyle(.roundedBorder)

                                Button("Listo") {
                                    editandoID = nil
                                }
                            } else {
                                Text(item.nombreProducto.isEmpty ? "Sin nombre" : item.nombreProducto)
                                    .font(.headline)

                                Spacer()

                                Button {
                                    editandoID = item.id
                                } label: {
                                    Image(systemName: "pencil")
                                }
                            }
                        }

                        Text("Precio final: $\(item.precioFinalConIva, specifier: "%.2f")")
                            .font(.subheadline)

                        Text("Cantidad: \(item.cantidadProductos) • Ganancia: \(item.porcentajeGanancia)%")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Text(formatterES.string(from: item.fecha))
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 6)
                }
                .onDelete(perform: eliminar)
            }
            .navigationTitle("Historial")
        }
    }

    func eliminar(at offsets: IndexSet) {
        historial.remove(atOffsets: offsets)
    }
}
