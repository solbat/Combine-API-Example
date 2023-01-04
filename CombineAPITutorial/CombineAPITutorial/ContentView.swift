//
//  ContentView.swift
//  CombineAPITutorial
//
//  Created by USER on 2023/01/04.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ViewModel
    
    init() {
        self._viewModel = StateObject.init(wrappedValue: ViewModel())
    }
    
    var body: some View {
        VStack {
            Button(action: {
                self.viewModel.fetchTodos()
            }, label: {
                Text("Todos 호출").foregroundColor(.white)
            })
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
