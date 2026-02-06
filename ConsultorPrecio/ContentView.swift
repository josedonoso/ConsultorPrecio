import SwiftUI

struct ContentView: View {

    @State private var historial: [CalculoGuardado] = []

    var body: some View {
        TabView {
            InicioView(historial: $historial)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Inicio")
                }

            HistorialView(historial: $historial)
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("Historial")
                }
            
            AjustesView(historial: $historial)
                .tabItem{
                    Label("Ajuste", systemImage: "gearshape.fill")
                }
        }
    }
}
