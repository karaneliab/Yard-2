codeunit 41003 CommLedgEntry
{
    TableNo = "Commission Ledger Entries";

    //    EventSubscriberInstance = StaticAutomatic;//


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterPostSalesLine, '', false, false)]
    local procedure UpdateCommissionLedgerOnSalesPost(var SalesCrMemoLine: Record "Sales Cr.Memo Line"; CommitIsSuppressed: Boolean; var SalesHeader: Record "Sales Header"; var SalesInvLine: Record "Sales Invoice Line"; var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line")
    var
        CommLedgerEntry: Record "Commission Ledger Entries";
        Pvline: Record "Purchase Line";
    begin

        CommLedgerEntry.Init();
        CommLedgerEntry."Posting Date" := SalesHeader."Posting Date";
        CommLedgerEntry."ChasisNo." := SalesLine.Description;
        CommLedgerEntry."Document No." := SalesHeader."No.";
        CommLedgerEntry.SalesPrice := SalesLine."Unit Price";
        CommLedgerEntry.CarMake := SalesLine.Make;
        CommLedgerEntry."FA No." := SalesLine."No.";
        CommLedgerEntry.PurchasePrice := Pvline."Unit Cost";
        CommLedgerEntry.CommissionPac := SalesLine.CommissionPac;
        CommLedgerEntry.CommissionAmount := SalesLine.Commission;
        CommLedgerEntry."EmployeeNo." := SalesLine.Employee;
        CommLedgerEntry.Branch := SalesLine."Shortcut Dimension 1 Code";
        CommLedgerEntry.Insert();

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterPostGenJnlLine, '', false, false)]
    local procedure OnAfterPostGenJnlLine(Balancing: Boolean; sender: Codeunit "Gen. Jnl.-Post Line"; var GenJournalLine: Record "Gen. Journal Line")
    var
        CommLedgerEntry: Record "Commission Ledger Entries";
    begin
        CommLedgerEntry.Init();
        CommLedgerEntry."Document No." := GenJournalLine."Document No.";
        CommLedgerEntry."Posting Date" := GenJournalLine."Posting Date";
        CommLedgerEntry.CarMake := GenJournalLine.Description;
        CommLedgerEntry.SalesPrice := GenJournalLine.Amount;
        // CommLedgerEntry.Insert();


    end;


}
