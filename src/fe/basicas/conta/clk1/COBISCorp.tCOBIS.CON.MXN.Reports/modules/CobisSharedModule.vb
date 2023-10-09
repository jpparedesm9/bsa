Imports COBISCorp.tCOBIS.CON.MXN.SharedLibrary
Public Class CobisSharedModule
    Inherits COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISModule(Of CobisSharedModule)
    Public Overrides Sub LoadComponent(ByVal sender As Object, ByVal componentEventArgs As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComponentEventArgs)
        MCOMMON.MCommonLoad()
        MyBase.LoadComponent(sender, componentEventArgs)
    End Sub
End Class
Public Module SharedFuncionalities
    Public ReadOnly Property FCodVal() As FSolRepRegClass
        Get
            Return FSolRepRegClass.GetInstance(Of FSolRepRegClass)()
        End Get
    End Property
End Module
