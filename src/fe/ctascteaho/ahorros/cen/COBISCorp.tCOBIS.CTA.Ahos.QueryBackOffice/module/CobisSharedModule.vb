Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Public Class CobisSharedModule
    Inherits COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISModule(Of CobisSharedModule)
    Public Overrides Sub LoadComponent(ByVal sender As Object, ByVal componentEventArgs As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComponentEventArgs)
        MCOMMON.MCommonLoad()
        MyBase.LoadComponent(sender, componentEventArgs)
    End Sub
End Class
Public Module SharedFuncionalities  
    Public ReadOnly Property FBusCausal() As FBusCausalClass
        Get
            Return FBusCausalClass.GetInstance(Of FBusCausalClass)()
        End Get
    End Property
    Public ReadOnly Property Ftran302() As Ftran302Class
        Get
            Return Ftran302Class.GetInstance(Of Ftran302Class)()
        End Get
    End Property
    Public ReadOnly Property FTran436() As FTran436Class
        Get
            Return FTran436Class.GetInstance(Of FTran436Class)()
        End Get
    End Property
    Public ReadOnly Property Ftran2872() As Ftran2872Class
        Get
            Return Ftran2872Class.GetInstance(Of Ftran2872Class)()
        End Get
    End Property
    Public ReadOnly Property Ftran2875() As Ftran2875Class
        Get
            Return Ftran2875Class.GetInstance(Of Ftran2875Class)()
        End Get
    End Property
    Public ReadOnly Property FGFuncionarios() As FGFuncionariosClass
        Get
            Return FGFuncionariosClass.GetInstance(Of FGFuncionariosClass)()
        End Get
    End Property
    Public ReadOnly Property FTranCME() As FTranCMEClass
        Get
            Return FTranCMEClass.GetInstance(Of FTranCMEClass)()
        End Get
    End Property
End Module
