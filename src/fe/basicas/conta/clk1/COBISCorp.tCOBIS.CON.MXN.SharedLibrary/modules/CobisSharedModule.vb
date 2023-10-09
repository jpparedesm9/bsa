Public Class CobisSharedModule
	Inherits COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISModule(Of CobisSharedModule)
	Public Overrides Sub LoadComponent(ByVal sender As Object, ByVal componentEventArgs As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComponentEventArgs)
		MCOMMON.MCommonLoad()
		MyBase.LoadComponent(sender, componentEventArgs)
	End Sub
End Class
Public Module SharedFuncionalities

End Module
