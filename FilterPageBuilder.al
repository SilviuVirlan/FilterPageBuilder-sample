pageextension 50111 "SVItems by Location Matrix" extends "Items by Location Matrix"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("&Item Availability by")
        {
            action(PurchaseItemByLocation)
            {
                Caption = 'Purchase Item By Location';
                ApplicationArea = All;
                Image = AboutNav;
                trigger OnAction()
                var
                    title: Text[30];
                    location: Record Location;
                    FilterLocationPageBuilder: FilterPageBuilder;
                    FilterIntegerPageBuilder: FilterPageBuilder;
                    Quantity: Record Integer;
                    LocationCode: Code[20];
                    Qty: Integer;
                    ErrInfo: ErrorInfo;
                begin
                    ErrInfo.Collectible := true;
                    title := 'Choose Location';
                    location.Reset();
                    FilterLocationPageBuilder.AddRecord(title, location);
                    if FilterLocationPageBuilder.RunModal() then begin
                        location.SetView(FilterLocationPageBuilder.GetView(title));

                        if location.FindFirst() then
                            LocationCode := location.Code;

                        FilterIntegerPageBuilder.AddRecord('Choose Quantity', Quantity);
                        if FilterIntegerPageBuilder.RunModal() then begin
                            Quantity.SetView(FilterIntegerPageBuilder.GetView('Choose Quantity'));
                            if Quantity.FindFirst() then
                                Qty := Quantity.Number;
                        end;

                        Message(StrSubstNo('Now create PO for Vendor: %1\Location = %2\Item = %3\Quantity = %4',
                                                                Rec."Vendor No.",
                                                                LocationCode,
                                                                Rec."No.",
                                                                Qty
                                                                ));

                    end;

                end;

            }
        }
    }
    [ErrorBehavior(ErrorBehavior::Collect)]
    local procedure MyCollectibleErrorProc()
    var
        E: ErrorInfo;
    begin
        Error(ErrorInfo.Create('Error 1', true));
        Error(ErrorInfo.Create('Error 2', true));
    end;

    var
        myInt: Integer;
}