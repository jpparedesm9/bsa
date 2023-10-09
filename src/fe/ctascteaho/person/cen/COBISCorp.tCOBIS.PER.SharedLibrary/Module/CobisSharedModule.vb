Public Class CobisSharedModule
	Inherits COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISModule(Of CobisSharedModule)
	Public Overrides Sub LoadComponent(ByVal sender As Object, ByVal componentEventArgs As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComponentEventArgs)
		MCOMMON.MCommonLoad()
		MyBase.LoadComponent(sender, componentEventArgs)
	End Sub
End Class
Public Module SharedFuncionalities
    Public ReadOnly Property FBuscarGrupo() As FBuscarGrupoClass
        Get
            Return FBuscarGrupoClass.GetInstance(Of FBuscarGrupoClass)()
        End Get
    End Property
	Public ReadOnly Property FBuscarLabor() As FBuscarLaborClass
		Get
			Return FBuscarLaborClass.GetInstance(Of FBuscarLaborClass)()
		End Get
	End Property
	Public ReadOnly Property FCatalogo() As FCatalogoClass
		Get
			Return FCatalogoClass.GetInstance(Of FCatalogoClass)()
		End Get
	End Property
	Public ReadOnly Property grid_valores() As grid_valoresClass
		Get
			Return grid_valoresClass.GetInstance(Of grid_valoresClass)()
		End Get
	End Property
	Public ReadOnly Property FSubtipo() As FSubtipoClass
		Get
			Return FSubtipoClass.GetInstance(Of FSubtipoClass)()
		End Get
	End Property
End Module
