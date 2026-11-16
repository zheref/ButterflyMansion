//
//  ContentView.swift
//  ButterflyMansion
//
//  Created by Sergio Daniel on 11/15/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationSplitView {
            ZStack {
                MansionBackground()

                if items.isEmpty {
                    emptyState
                } else {
                    List {
                        ForEach(items) { item in
                            NavigationLink {
                                detail(for: item)
                            } label: {
                                row(for: item)
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparatorTint(Color.mansionBorder)
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Butterfly Mansion")
            .toolbar {
                ToolbarItem(placement: .largeTitle) {
                    Text("Butterfly Mansion")
                        .mansionDisplayText()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .tint(.mansionPrimary)
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.mansionPrimary)
                }
            }
        } detail: {
            ZStack {
                MansionBackground()
                VStack(spacing: MansionSpacing.sm) {
                    ButterflyGlyph(tint: .mansionAccent, size: 40)
                    Text("Select a recovery record")
                        .mansionSubheadlineText()
                }
            }
        }
        .tint(.mansionPrimary)
    }

    private func row(for item: Item) -> some View {
        HStack(spacing: MansionSpacing.md) {
            ButterflyGlyph(tint: .mansionAccent, size: 22)
            VStack(alignment: .leading, spacing: 2) {
                Text(item.timestamp, format: Date.FormatStyle(date: .abbreviated, time: .omitted))
                    .mansionHeadlineText()
                Text(item.timestamp, format: Date.FormatStyle(date: .omitted, time: .shortened))
                    .mansionCaptionText()
            }
        }
        .padding(.vertical, MansionSpacing.xs)
    }

    private func detail(for item: Item) -> some View {
        ZStack {
            MansionBackground()
            VStack(spacing: MansionSpacing.md) {
                ButterflyGlyph(tint: .mansionSecondary, size: 56)
                Text("Entry recorded")
                    .mansionTitleText()
                Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    .mansionBodyText()
            }
            .padding(MansionSpacing.lg)
            .mansionCard()
            .padding(MansionSpacing.lg)
        }
    }

    private var emptyState: some View {
        VStack(spacing: MansionSpacing.md) {
            ButterflyGlyph(tint: .mansionPrimary, size: 48)
            Text("The mansion is quiet")
                .mansionHeadlineText()
            Text("Add an entry to begin your recovery log.")
                .mansionSubheadlineText()
                .multilineTextAlignment(.center)
            Button("Add Entry", action: addItem)
                .buttonStyle(.mansionPrimary)
                .padding(.top, MansionSpacing.sm)
        }
        .padding(MansionSpacing.xl)
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

#Preview("Populated") {
    let container = try! ModelContainer(for: Item.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    container.mainContext.insert(Item(timestamp: .now))
    container.mainContext.insert(Item(timestamp: .now.addingTimeInterval(-86_400)))
    return ContentView()
        .modelContainer(container)
}
