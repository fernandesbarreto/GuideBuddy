//
//  FatherInvestmentViewModel.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 26/10/25.
//


//
//  FatherInvestmentViewModel.swift
//  dindin
//
//  Created by Assistant on 26/10/25.
//

import Foundation
import SwiftUI
import CloudKit
import Combine

@MainActor
final class FatherInvestmentViewModel: ObservableObject {
    // MARK: - Published State
    @Published private(set) var investments: [Investment] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    @Published var showError: Bool = false
    
    // MARK: - Context
    private(set) var currentUser: UserProfile?
    private(set) var currentFamily: Family?
    
    // MARK: - Services
    private let investmentService: InvestmentServiceProtocol
    
    // MARK: - Private
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(investmentService: InvestmentServiceProtocol = InvestmentService()) {
        self.investmentService = investmentService
    }
    
    // MARK: - Context
    func setContext(userProfile: UserProfile?, family: Family?) {
        self.currentUser = userProfile
        self.currentFamily = family
    }
    
    // MARK: - Load
    func loadInvestmentsForCurrentFamily() {
        guard let family = currentFamily else { return }
        isLoading = true
        errorMessage = nil
        
        investmentService.fetchInvestmentsForFamily(family)
            // Aplique accrual se necessário (um por um)
            .flatMap { [weak self] investments -> AnyPublisher<[Investment], Error> in
                guard let self = self else { return Just(investments).setFailureType(to: Error.self).eraseToAnyPublisher() }
                let now = Date()
                let accrualPublishers = investments.map { inv in
                    self.investmentService.accrueInvestmentIfNeeded(inv, asOf: now)
                }
                if accrualPublishers.isEmpty { return Just(investments).setFailureType(to: Error.self).eraseToAnyPublisher() }
                return Publishers.MergeMany(accrualPublishers).collect().eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.handleError(error, context: "loading investments for family")
                }
            } receiveValue: { [weak self] updatedInvestments in
                self?.investments = updatedInvestments
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Helpers
    private func handleError(_ error: Error, context: String) {
        errorMessage = "Erro \(context): \(error.localizedDescription)"
        showError = true
    }
}


