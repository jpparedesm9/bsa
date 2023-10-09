Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Public Class CobisSharedModule
    Inherits COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISModule(Of CobisSharedModule)
    Public Overrides Sub LoadComponent(ByVal sender As Object, ByVal componentEventArgs As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComponentEventArgs)
        MCOMMON.MCommonLoad()
        MyBase.LoadComponent(sender, componentEventArgs)
    End Sub
End Class
Public Module SharedFuncionalities
	Public ReadOnly Property FHistoricoAM() As FHistoricoAMClass
		Get
			Return FHistoricoAMClass.GetInstance(Of FHistoricoAMClass)()
		End Get
	End Property
	Public ReadOnly Property FHistoricoAS() As FHistoricoASClass
		Get
			Return FHistoricoASClass.GetInstance(Of FHistoricoASClass)()
		End Get
	End Property
	Public ReadOnly Property FTran223() As FTran223Class
		Get
			Return FTran223Class.GetInstance(Of FTran223Class)()
		End Get
	End Property
	Public ReadOnly Property FTran232() As FTran232Class
		Get
			Return FTran232Class.GetInstance(Of FTran232Class)()
		End Get
	End Property
	Public ReadOnly Property FTran234() As FTran234Class
		Get
			Return FTran234Class.GetInstance(Of FTran234Class)()
		End Get
	End Property
End Module
