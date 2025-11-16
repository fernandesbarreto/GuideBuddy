//
//  Investment.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 26/10/25.
//


//
//  Investment.swift
//  dindin
//
//  Created by Assistant on 26/10/25.
//

import Foundation
import CloudKit

/// Represents an Investment (with monthly yield) in CloudKit
struct Investment: Identifiable, Equatable {
    let id: String
    let name: String
    /// Monthly yield percentage (e.g., 1.5 for 1.5%/month)
    let interestPercentage: Double
    let createdDate: Date
    let dueDate: Date?
    let initialValue: Double
    let currentValue: Double
    /// Last time the investment yield was accrued
    let lastAccruedDate: Date?
    /// References
    let familyReference: CKRecord.Reference
    let createdBy: CKRecord.Reference
    let assignedTo: CKRecord.Reference?
    /// Soft delete flag
    let isActive: Bool
    /// Underlying CKRecord
    let record: CKRecord
    
    init(record: CKRecord) {
        self.id = record.recordID.recordName
        self.name = record[FieldKey.name] as? String ?? ""
        self.interestPercentage = record[FieldKey.interestPercentage] as? Double ?? 0.0
        self.createdDate = record[FieldKey.createdDate] as? Date ?? Date()
        self.dueDate = record[FieldKey.dueDate] as? Date
        self.initialValue = record[FieldKey.initialValue] as? Double ?? 0.0
        self.currentValue = record[FieldKey.currentValue] as? Double ?? 0.0
        self.lastAccruedDate = record[FieldKey.lastAccruedDate] as? Date
        self.familyReference = record[FieldKey.familyReference] as? CKRecord.Reference ?? CKRecord.Reference(recordID: CKRecord.ID(recordName: "unknown"), action: .none)
        self.createdBy = record[FieldKey.createdBy] as? CKRecord.Reference ?? CKRecord.Reference(recordID: CKRecord.ID(recordName: "unknown"), action: .none)
        self.assignedTo = record[FieldKey.assignedTo] as? CKRecord.Reference
        self.isActive = record[FieldKey.isActive] as? Bool ?? true
        self.record = record
    }
    
    static func createRecord(
        name: String,
        interestPercentage: Double,
        createdDate: Date = Date(),
        dueDate: Date? = nil,
        initialValue: Double,
        familyReference: CKRecord.Reference,
        createdBy: CKRecord.Reference,
        assignedTo: CKRecord.Reference? = nil
    ) -> CKRecord {
        let record = CKRecord(recordType: RecordType.investment)
        record[FieldKey.name] = name as CKRecordValue
        record[FieldKey.interestPercentage] = interestPercentage as CKRecordValue
        record[FieldKey.createdDate] = createdDate as CKRecordValue
        if let dueDate { record[FieldKey.dueDate] = dueDate as CKRecordValue }
        record[FieldKey.initialValue] = initialValue as CKRecordValue
        record[FieldKey.currentValue] = initialValue as CKRecordValue
        record[FieldKey.lastAccruedDate] = createdDate as CKRecordValue
        record[FieldKey.familyReference] = familyReference
        record[FieldKey.createdBy] = createdBy
        if let assignedTo { record[FieldKey.assignedTo] = assignedTo }
        record[FieldKey.isActive] = true as CKRecordValue
        return record
    }
    
    /// Calculates number of full months between two dates
    static func monthsBetween(_ from: Date, _ to: Date) -> Int {
        let calendar = Calendar.current
        let comps = calendar.dateComponents([.year, .month], from: from, to: to)
        let months = (comps.year ?? 0) * 12 + (comps.month ?? 0)
        return max(0, months)
    }
    
    /// Computes compound value applying monthly interest for given months
    func compoundedValue(applyingMonths months: Int) -> Double {
        guard months > 0 else { return currentValue }
        let rate = interestPercentage / 100.0
        return currentValue * pow(1.0 + rate, Double(months))
    }
}

extension Investment {
    enum RecordType {
        static let investment = "Investment"
    }
    
    enum FieldKey {
        static let name = "name"
        static let interestPercentage = "interestPercentage"
        static let createdDate = "createdDate"
        static let dueDate = "dueDate"
        static let initialValue = "initialValue"
        static let currentValue = "currentValue"
        static let lastAccruedDate = "lastAccruedDate"
        static let familyReference = "familyReference"
        static let createdBy = "createdBy"
        static let assignedTo = "assignedTo"
        static let isActive = "isActive"
    }
}

extension Investment: CloudKitRecord {
    var recordID: String? { record.recordID.recordName }
    func toCKRecord() -> CKRecord { record }
    static func fromCKRecord(_ record: CKRecord) -> Investment { Investment(record: record) }
}


