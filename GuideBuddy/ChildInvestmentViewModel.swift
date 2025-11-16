//
//  ChildInvestmentViewModel.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 26/10/25.
//


//
//  ChildInvestmentViewModel.swift
//  dindin
//
//  Created by Assistant on 26/10/25.
//

import Foundation
import SwiftUI
import CloudKit
import Combine

@MainActor
final class ChildInvestmentViewModel: ObservableObject {
    // MARK: - Published State
    @Published private(set) var investments: [Investment] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var isSaving: Bool = false
    @Published private(set) var isDeleting: Bool = false
    @Published private(set) var errorMessage: String?
    @Published var showError: Bool = false
    @Published var showSuccessMessage: Bool = false
    @Published private(set) var successMessage: String?
    
    // MARK: - Context
    private(set) var userProfile: UserProfile?
    private(set) var family: Family?
    
    // MARK: - Services
    private let investmentService: InvestmentServiceProtocol
    
    // MARK: - Private
    private var cancellables = Set<AnyCancellable>()
    
    init(investmentService: InvestmentServiceProtocol = InvestmentService()) {
        self.investmentService = investmentService
    }
    
    // MARK: - Context
    func setContext(userProfile: UserProfile?, family: Family?) {
        self.userProfile = userProfile
        self.family = family
    }
    
    // MARK: - Loads
    func loadInvestmentsForCurrentUser() {
        guard let user = userProfile else { return }
        isLoading = true
        errorMessage = nil
        investmentService.fetchInvestmentsForUser(user)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.handleError(error, context: "loading investments for user")
                }
            } receiveValue: { [weak self] items in
                self?.investments = items
            }
            .store(in: &cancellables)
    }
    
    // MARK: - CRUD
    func createInvestment(name: String, interestPercentage: Double, dueDate: Date?, initialValue: Double) {
        guard let user = userProfile, let family = family else {
            handleError(GoalsValidationError.missingRequiredFields, context: "creating investment - missing user or family")
            return
        }
        guard !name.isEmpty && interestPercentage >= 0 && initialValue > 0 else {
            handleError(GoalsValidationError.invalidInput, context: "creating investment - invalid fields")
            return
        }
        isSaving = true
        let familyRef = CKRecord.Reference(recordID: family.record.recordID, action: .none)
        let createdByRef = CKRecord.Reference(recordID: user.record.recordID, action: .none)
        let assignedToRef = CKRecord.Reference(recordID: user.record.recordID, action: .none)
        investmentService.createInvestment(name: name, interestPercentage: interestPercentage, createdDate: Date(), dueDate: dueDate, initialValue: initialValue, familyReference: familyRef, createdBy: createdByRef, assignedTo: assignedToRef)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isSaving = false
                if case .failure(let error) = completion {
                    self?.handleError(error, context: "creating investment")
                }
            } receiveValue: { [weak self] investment in
                guard let self = self else { return }
                var items = self.investments
                items.insert(investment, at: 0)
                self.investments = items
                self.successMessage = "Investimento criado com sucesso!"
                self.showSuccessMessage = true
            }
            .store(in: &cancellables)
    }
    
    func deleteInvestment(_ investment: Investment) {
        guard let user = userProfile else { return }
        // Apenas quem criou pode apagar
        guard investment.createdBy.recordID == user.record.recordID else {
            handleError(GoalsValidationError.unauthorized, context: "deleting investment - not authorized")
            return
        }
        isDeleting = true
        investmentService.deleteInvestment(investment)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isDeleting = false
                if case .failure(let error) = completion {
                    self?.handleError(error, context: "deleting investment")
                }
            } receiveValue: { [weak self] _ in
                guard let self = self else { return }
                self.investments.removeAll { $0.id == investment.id }
                self.successMessage = "Investimento excluído com sucesso!"
                self.showSuccessMessage = true
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Helpers
    private func handleError(_ error: Error, context: String) {
        errorMessage = "Erro \(context): \(error.localizedDescription)"
        showError = true
    }
}


