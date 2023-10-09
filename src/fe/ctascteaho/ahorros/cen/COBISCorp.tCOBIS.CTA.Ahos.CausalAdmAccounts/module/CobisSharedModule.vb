Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Public Class CobisSharedModule
    Inherits COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISModule(Of CobisSharedModule)
    Public Overrides Sub LoadComponent(ByVal sender As Object, ByVal componentEventArgs As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComponentEventArgs)
        MCOMMON.MCommonLoad()
        MyBase.LoadComponent(sender, componentEventArgs)
    End Sub
End Class
Public Module SharedFuncionalities
	Public ReadOnly Property FMantCausalOfi() As FMantCausalOfiClass
		Get
			Return FMantCausalOfiClass.GetInstance(Of FMantCausalOfiClass)()
		End Get
	End Property
	Public ReadOnly Property FTran2581() As FTran2581Class
		Get
			Return FTran2581Class.GetInstance(Of FTran2581Class)()
		End Get
	End Property
	Public ReadOnly Property FTran2696() As FTran2696Class
		Get
			Return FTran2696Class.GetInstance(Of FTran2696Class)()
		End Get
	End Property
	Public ReadOnly Property FTran2913() As FTran2913Class
		Get
			Return FTran2913Class.GetInstance(Of FTran2913Class)()
		End Get
	End Property
	Public ReadOnly Property FTRAN707() As FTRAN707Class
		Get
			Return FTRAN707Class.GetInstance(Of FTRAN707Class)()
		End Get
	End Property
End Module
