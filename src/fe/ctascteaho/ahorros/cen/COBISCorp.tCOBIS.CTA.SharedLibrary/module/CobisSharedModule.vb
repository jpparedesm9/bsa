Public Class CobisSharedModule
	Inherits COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISModule(Of CobisSharedModule)
	Public Overrides Sub LoadComponent(ByVal sender As Object, ByVal componentEventArgs As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComponentEventArgs)
		MCOMMON.MCommonLoad()
		MyBase.LoadComponent(sender, componentEventArgs)
	End Sub
End Class
Public Module SharedFuncionalities

    Public ReadOnly Property FHelpCta() As FHelpCtaClass
        Get
            Return FHelpCtaClass.GetInstance(Of FHelpCtaClass)()
        End Get
    End Property
    Public ReadOnly Property FHelpOficial() As FHelpOficialClass
        Get
            Return FHelpOficialClass.GetInstance(Of FHelpOficialClass)()
        End Get
    End Property
    Public ReadOnly Property FCatalogo() As FCatalogoClass
        Get
            Return FCatalogoClass.GetInstance(Of FCatalogoClass)()
        End Get
    End Property
    Public ReadOnly Property FAcerca() As FAcercaClass
        Get
            Return FAcercaClass.GetInstance(Of FAcercaClass)()
        End Get
    End Property
    Public ReadOnly Property FAcuseChq() As FAcuseChqClass
        Get
            Return FAcuseChqClass.GetInstance(Of FAcuseChqClass)()
        End Get
    End Property
    Public ReadOnly Property FAyuda() As FAyudaClass
        Get
            Return FAyudaClass.GetInstance(Of FAyudaClass)()
        End Get
    End Property
    Public ReadOnly Property FAyuda2() As FAyuda2Class
        Get
            Return FAyuda2Class.GetInstance(Of FAyuda2Class)()
        End Get
    End Property
    Public ReadOnly Property FClave() As FClaveClass
        Get
            Return FClaveClass.GetInstance(Of FClaveClass)()
        End Get
    End Property
    Public ReadOnly Property Fdatadi() As FdatadiClass
        Get
            Return FdatadiClass.GetInstance(Of FdatadiClass)()
        End Get
    End Property
    Public ReadOnly Property FPrint() As FPrintClass
        Get
            Return FPrintClass.GetInstance(Of FPrintClass)()
        End Get
    End Property
    Public ReadOnly Property FPUNTOCB() As FPUNTOCBClass
        Get
            Return FPUNTOCBClass.GetInstance(Of FPUNTOCBClass)()
        End Get
    End Property
    Public ReadOnly Property FRegistros() As FRegistrosClass
        Get
            Return FRegistrosClass.GetInstance(Of FRegistrosClass)()
        End Get
    End Property

    'Public ReadOnly Property Ftran2875() As Ftran2875Class
    '	Get
    '		Return Ftran2875Class.GetInstance(Of Ftran2875Class)()
    '	End Get
    'End Property

    Public ReadOnly Property FTran204() As FTran204Class
        Get
            Return FTran204Class.GetInstance(Of FTran204Class)()
        End Get
    End Property

    Public ReadOnly Property FTran367() As FTran367Class
        Get
            Return FTran367Class.GetInstance(Of FTran367Class)()
        End Get
    End Property

    Public ReadOnly Property FTran490() As FTran490Class
        Get
            Return FTran490Class.GetInstance(Of FTran490Class)()
        End Get
    End Property
    Public ReadOnly Property ftran496() As ftran496Class
        Get
            Return ftran496Class.GetInstance(Of ftran496Class)()
        End Get
    End Property
    Public ReadOnly Property grid_valores() As grid_valoresClass
        Get
            Return grid_valoresClass.GetInstance(Of grid_valoresClass)()
        End Get
    End Property
End Module
