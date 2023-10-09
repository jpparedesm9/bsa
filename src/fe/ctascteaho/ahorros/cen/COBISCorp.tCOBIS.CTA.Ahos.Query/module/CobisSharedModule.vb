Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Public Class CobisSharedModule
    Inherits COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISModule(Of CobisSharedModule)
    Public Overrides Sub LoadComponent(ByVal sender As Object, ByVal componentEventArgs As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComponentEventArgs)
        MCOMMON.MCommonLoad()
        MyBase.LoadComponent(sender, componentEventArgs)
    End Sub
End Class
Public Module SharedFuncionalities  
    Public ReadOnly Property Ftran434() As Ftran434Class
        Get
            Return Ftran434Class.GetInstance(Of Ftran434Class)()
        End Get
    End Property
    Public ReadOnly Property FBusArchAlianza() As FBusArchAlianzaClass
        Get
            Return FBusArchAlianzaClass.GetInstance(Of FBusArchAlianzaClass)()
        End Get
    End Property
    Public ReadOnly Property FBusCta() As FBusCtaClass
        Get
            Return FBusCtaClass.GetInstance(Of FBusCtaClass)()
        End Get
    End Property

    Public ReadOnly Property FCtranAut() As FCtranAutClass
        Get
            Return FCtranAutClass.GetInstance(Of FCtranAutClass)()
        End Get
    End Property

    Public ReadOnly Property FTran096() As FTran096Class
        Get
            Return FTran096Class.GetInstance(Of FTran096Class)()
        End Get
    End Property
    Public ReadOnly Property FTran216() As FTran216Class
        Get
            Return FTran216Class.GetInstance(Of FTran216Class)()
        End Get
    End Property
    Public ReadOnly Property FTran235() As FTran235Class
        Get
            Return FTran235Class.GetInstance(Of FTran235Class)()
        End Get
    End Property
    Public ReadOnly Property FTran245() As FTran245Class
        Get
            Return FTran245Class.GetInstance(Of FTran245Class)()
        End Get
    End Property
    Public ReadOnly Property FTran247() As FTran247Class
        Get
            Return FTran247Class.GetInstance(Of FTran247Class)()
        End Get
    End Property
    Public ReadOnly Property FTran343() As FTran343Class
        Get
            Return FTran343Class.GetInstance(Of FTran343Class)()
        End Get
    End Property
End Module
