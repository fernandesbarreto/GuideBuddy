//
//  InvestmentServiceProtocol.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 26/10/25.
//


//
//  InvestmentService.swift
//  dindin
//
//  Created by Assistant on 26/10/25.
//

import Foundation
import CloudKit
import Combine

protocol InvestmentServiceProtocol {
    func createInvestment(name: String, interestPercentage: Double, createdDate: Date, dueDate: Date?, initialValue: Double, familyReference: CKRecord.Reference, createdBy: CKRecord.Reference, assignedTo: CKRecord.Reference?) -> AnyPublisher<Investment, Error>
    func fetchInvestmentsForFamily(_ family: Family) -> AnyPublisher<[Investment], Error>
    func fetchInvestmentsForUser(_ userProfile: UserProfile) -> AnyPublisher<[Investment], Error>
    func updateInvestment(_ investment: Investment) -> AnyPublisher<Investment, Error>
    func deleteInvestment(_ investment: Investment) -> AnyPublisher<Void, Error>
    /// Accrues monthly interest since lastAccruedDate and saves currentValue/lastAccruedDate
    func accrueInvestmentIfNeeded(_ investment: Investment, asOf date: Date) -> AnyPublisher<Investment, Error>
}

final class InvestmentService: BaseCloudKitService, InvestmentServiceProtocol {
    
    func createInvestment(
        name: String,
        interestPercentage: Double,
        createdDate: Date = Date(),
        dueDate: Date? = nil,
        initialValue: Double,
        familyReference: CKRecord.Reference,
        createdBy: CKRecord.Reference,
        assignedTo: CKRecord.Reference? = nil
    ) -> AnyPublisher<Investment, Error> {
        let record = Investment.createRecord(
            name: name,
            interestPercentage: interestPercentage,
            createdDate: createdDate,
            dueDate: dueDate,
            initialValue: initialValue,
            familyReference: familyReference,
            createdBy: createdBy,
            assignedTo: assignedTo
        )
        return create(record, type: Investment.self)
    }
    
    func fetchInvestmentsForFamily(_ family: Family) -> AnyPublisher<[Investment], Error> {
        let familyRef = CKRecord.Reference(recordID: family.record.recordID, action: .none)
        let predicate = NSPredicate(format: "familyReference == %@ AND isActive == YES", familyRef)
        let sortDescriptors = [NSSortDescriptor(key: Investment.FieldKey.createdDate, ascending: false)]
        return fetch(recordType: Investment.RecordType.investment, predicate: predicate, sortDescriptors: sortDescriptors, type: Investment.self)
    }
    
    func fetchInvestmentsForUser(_ userProfile: UserProfile) -> AnyPublisher<[Investment], Error> {
        let userRef = CKRecord.Reference(recordID: userProfile.record.recordID, action: .none)
        let predicate = NSPredicate(format: "assignedTo == %@ AND isActive == YES", userRef)
        let sortDescriptors = [NSSortDescriptor(key: Investment.FieldKey.createdDate, ascending: false)]
        return fetch(recordType: Investment.RecordType.investment, predicate: predicate, sortDescriptors: sortDescriptors, type: Investment.self)
    }
    
    func updateInvestment(_ investment: Investment) -> AnyPublisher<Investment, Error> {
        return update(investment)
    }
    
    func deleteInvestment(_ investment: Investment) -> AnyPublisher<Void, Error> {
        return softDelete(investment)
    }
    
    func accrueInvestmentIfNeeded(_ investment: Investment, asOf date: Date = Date()) -> AnyPublisher<Investment, Error> {
        let last = investment.lastAccruedDate ?? investment.createdDate
        let months = Investment.monthsBetween(last, date)
        guard months > 0 else { return Just(investment).setFailureType(to: Error.self).eraseToAnyPublisher() }
        var record = investment.toCKRecord()
        let newValue = investment.compoundedValue(applyingMonths: months)
        record[Investment.FieldKey.currentValue] = newValue as CKRecordValue
        record[Investment.FieldKey.lastAccruedDate] = date as CKRecordValue
        let updated = Investment(record: record)
        return update(updated)
    }
}


