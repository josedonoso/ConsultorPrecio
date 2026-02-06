import SwiftUI

struct AjustesView: View {

    @AppStorage("porcentajeIVA") private var porcentajeIVA: Double = 19
    @AppStorage("modoOscuro") private var modoOscuro: Bool = false

    @Binding var historial: [CalculoGuardado]

    @State private var mostrarAlerta = false

    var body: some View {
        NavigationStack {
            Form {

                // INFO APP
                Section {
                    VStack(spacing: 6) {
                        Text("Consultor de Precios")
                            .font(.headline)

                        Text("Versión 1.0")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Text("Desarrollada por Jose")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                }

                // IVA
                Section(header: Text("Impuestos")) {
                    HStack {
                        Text("IVA")
                        Spacer()
                        Text("\(Int(porcentajeIVA))%")
                            .foregroundColor(.blue)
                    }
                }

                // APARIENCIA
                Section(header: Text("Apariencia")) {
                    Toggle("Modo oscuro", isOn: $modoOscuro)
                }

                // HISTORIAL
                Section(header: Text("Historial")) {
                    Button(role: .destructive) {
                        mostrarAlerta = true
                    } label: {
                        Text("Eliminar todo el historial")
                    }
                }
            }
            .navigationTitle("Ajustes")
            .alert("¿Eliminar historial?", isPresented: $mostrarAlerta) {
                Button("Eliminar", role: .destructive) {
                    historial.removeAll()
                }
                Button("Cancelar", role: .cancel) { }
            } message: {
                Text("Esta acción no se puede deshacer")
            }
        }
    }
}
