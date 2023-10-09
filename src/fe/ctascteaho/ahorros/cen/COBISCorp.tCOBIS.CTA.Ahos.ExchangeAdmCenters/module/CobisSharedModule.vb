Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Public Class CobisSharedModule
    Inherits COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISModule(Of CobisSharedModule)
    Public Overrides Sub LoadComponent(ByVal sender As Object, ByVal componentEventArgs As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComponentEventArgs)
        MCOMMON.MCommonLoad()
        MyBase.LoadComponent(sender, componentEventArgs)
    End Sub
End Class
Public Module SharedFuncionalities
	Public ReadOnly Property FTipoCanje() As FTipoCanjeClass
		Get
			Return FTipoCanjeClass.GetInstance(Of FTipoCanjeClass)()
		End Get
	End Property
	Public ReadOnly Property FTran2564() As FTran2564Class
		Get
			Return FTran2564Class.GetInstance(Of FTran2564Class)()
		End Get
	End Property
	Public ReadOnly Property FTran2810() As FTran2810Class
		Get
			Return FTran2810Class.GetInstance(Of FTran2810Class)()
		End Get
	End Property
End Module
