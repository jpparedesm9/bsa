Public Class CobisSharedModule
	Inherits COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISModule(Of CobisSharedModule)
	Public Overrides Sub LoadComponent(ByVal sender As Object, ByVal componentEventArgs As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComponentEventArgs)
		MCOMMON.MCommonLoad()
		MyBase.LoadComponent(sender, componentEventArgs)
	End Sub
End Class
Public Module SharedFuncionalities
	Public ReadOnly Property FAyuda() As FAyudaClass
		Get
			Return FAyudaClass.GetInstance(Of FAyudaClass)()
		End Get
	End Property
	Public ReadOnly Property FBuscarCliente() As FBuscarClienteClass
		Get
			Return FBuscarClienteClass.GetInstance(Of FBuscarClienteClass)()
		End Get
	End Property
End Module
