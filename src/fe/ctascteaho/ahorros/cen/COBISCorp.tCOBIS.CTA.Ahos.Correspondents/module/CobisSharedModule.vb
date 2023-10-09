Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Public Class CobisSharedModule
    Inherits COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISModule(Of CobisSharedModule)
    Public Overrides Sub LoadComponent(ByVal sender As Object, ByVal componentEventArgs As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComponentEventArgs)
        MCOMMON.MCommonLoad()
        MyBase.LoadComponent(sender, componentEventArgs)
    End Sub
End Class
Public Module SharedFuncionalities
	Public ReadOnly Property FConsultaCupoCB() As FConsultaCupoCBClass
		Get
			Return FConsultaCupoCBClass.GetInstance(Of FConsultaCupoCBClass)()
		End Get
	End Property
	Public ReadOnly Property FConRedCB() As FConRedCBClass
		Get
			Return FConRedCBClass.GetInstance(Of FConRedCBClass)()
		End Get
	End Property
	Public ReadOnly Property FConsMovCB() As FConsMovCBClass
		Get
			Return FConsMovCBClass.GetInstance(Of FConsMovCBClass)()
		End Get
	End Property
	Public ReadOnly Property FMantenimientoCupoCB() As FMantenimientoCupoCBClass
		Get
			Return FMantenimientoCupoCBClass.GetInstance(Of FMantenimientoCupoCBClass)()
		End Get
	End Property
	Public ReadOnly Property FDevRecCB() As FDevRecCBClass
		Get
			Return FDevRecCBClass.GetInstance(Of FDevRecCBClass)()
		End Get
	End Property
	Public ReadOnly Property FGesCtaCB() As FGesCtaCBClass
		Get
			Return FGesCtaCBClass.GetInstance(Of FGesCtaCBClass)()
		End Get
	End Property
	Public ReadOnly Property FMantenimientoCB() As FMantenimientoCBClass
		Get
			Return FMantenimientoCBClass.GetInstance(Of FMantenimientoCBClass)()
		End Get
	End Property
	Public ReadOnly Property FTran303() As FTran303Class
		Get
			Return FTran303Class.GetInstance(Of FTran303Class)()
		End Get
	End Property
End Module
