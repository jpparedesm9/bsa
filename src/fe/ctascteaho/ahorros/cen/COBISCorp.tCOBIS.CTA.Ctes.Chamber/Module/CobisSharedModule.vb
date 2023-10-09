Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Public Class CobisSharedModule
Inherits COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISModule(Of CobisSharedModule)
Public Overrides Sub LoadComponent(ByVal sender As Object, ByVal componentEventArgs As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComponentEventArgs)
MCommon.MCommonLoad()
MyBase.LoadComponent(sender, componentEventArgs)
End Sub
End Class
Public Module SharedFuncionalities
    Public ReadOnly Property FCheqAprobRechaz() As FCheqAprobRechazClass
        Get
            Return FCheqAprobRechazClass.GetInstance(Of FCheqAprobRechazClass)()
        End Get
    End Property
End Module


