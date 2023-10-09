Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Public Class CobisSharedModule
    Inherits COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISModule(Of CobisSharedModule)
    Public Overrides Sub LoadComponent(ByVal sender As Object, ByVal componentEventArgs As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComponentEventArgs)
        MCOMMON.MCommonLoad()
        MyBase.LoadComponent(sender, componentEventArgs)
    End Sub
End Class
Public Module SharedFuncionalities   
    Public ReadOnly Property FREEXPEDIR() As FREEXPEDIRClass
        Get
            Return FREEXPEDIRClass.GetInstance(Of FREEXPEDIRClass)()
        End Get
    End Property
    Public ReadOnly Property FArchTransf() As FArchTransfClass
        Get
            Return FArchTransfClass.GetInstance(Of FArchTransfClass)()
        End Get
    End Property
    Public ReadOnly Property FAUTRETOF() As FAUTRETOFClass
        Get
            Return FAUTRETOFClass.GetInstance(Of FAUTRETOFClass)()
        End Get
    End Property
    Public ReadOnly Property FHold() As FHoldClass
        Get
            Return FHoldClass.GetInstance(Of FHoldClass)()
        End Get
    End Property
    Public ReadOnly Property FRelCtaCanal() As FRelCtaCanalClass
        Get
            Return FRelCtaCanalClass.GetInstance(Of FRelCtaCanalClass)()
        End Get
    End Property

    Public ReadOnly Property FTRAN2850() As FTRAN2850Class
        Get
            Return FTRAN2850Class.GetInstance(Of FTRAN2850Class)()
        End Get
    End Property

    Public ReadOnly Property FTran358() As FTran358Class
        Get
            Return FTran358Class.GetInstance(Of FTran358Class)()
        End Get
    End Property

    Public ReadOnly Property FTran2576() As FTran2576Class
        Get
            Return FTran2576Class.GetInstance(Of FTran2576Class)()
        End Get
    End Property
    Public ReadOnly Property FTra2700() As FTra2700Class
        Get
            Return FTra2700Class.GetInstance(Of FTra2700Class)()
        End Get
    End Property
    Public ReadOnly Property Ftran2797() As Ftran2797Class
        Get
            Return Ftran2797Class.GetInstance(Of Ftran2797Class)()
        End Get
    End Property
    Public ReadOnly Property FTran080() As FTran080Class
        Get
            Return FTran080Class.GetInstance(Of FTran080Class)()
        End Get
    End Property
    Public ReadOnly Property FTran090() As FTran090Class
        Get
            Return FTran090Class.GetInstance(Of FTran090Class)()
        End Get
    End Property
    Public ReadOnly Property FTran098() As FTran098Class
        Get
            Return FTran098Class.GetInstance(Of FTran098Class)()
        End Get
    End Property
    Public ReadOnly Property FTran205() As FTran205Class
        Get
            Return FTran205Class.GetInstance(Of FTran205Class)()
        End Get
    End Property
    Public ReadOnly Property FTran2938() As FTran2938Class
        Get
            Return FTran2938Class.GetInstance(Of FTran2938Class)()
        End Get
    End Property

    Public ReadOnly Property FTran437() As FTran437Class
        Get
            Return FTran437Class.GetInstance(Of FTran437Class)()
        End Get
    End Property

    Public ReadOnly Property FTran202() As FTran202Class
        Get
            Return FTran202Class.GetInstance(Of FTran202Class)()
        End Get
    End Property
End Module
