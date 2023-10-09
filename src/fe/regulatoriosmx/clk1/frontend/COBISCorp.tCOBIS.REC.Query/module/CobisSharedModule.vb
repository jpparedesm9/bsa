Imports COBISCorp.tCOBIS.REC.SharedLibrary
Public Class CobisSharedModule
    Inherits COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISModule(Of CobisSharedModule)
    Public Overrides Sub LoadComponent(ByVal sender As Object, ByVal componentEventArgs As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComponentEventArgs)
        MCOMMON.MCommonLoad()
        MyBase.LoadComponent(sender, componentEventArgs)
    End Sub
End Class
Public Module SharedFuncionalities
    Public ReadOnly Property FRESGISTRANS() As FRESGISTRANSClass
        Get
            Return FRESGISTRANSClass.GetInstance(Of FRESGISTRANSClass)()
        End Get
    End Property
    Public ReadOnly Property FCONSTRAN() As FCONSTRANClass
        Get
            Return FCONSTRANClass.GetInstance(Of FCONSTRANClass)()
        End Get
    End Property
End Module
