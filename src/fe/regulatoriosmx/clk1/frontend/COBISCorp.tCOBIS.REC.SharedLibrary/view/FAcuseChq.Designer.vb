<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FAcuseChqClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
		InitializelblEtiqueta()
		InitializecmdBoton()
	End Sub
    Private Sub ReleaseResources(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Closed
        Dispose(True)
    End Sub
    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
     Protected Overloads Overrides Sub Dispose(ByVal Disposing As Boolean)
        If Disposing Then
            If Not (components Is Nothing) Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(Disposing)
    End Sub
    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer
    Friend WithEvents COBISViewResizer As COBISCorp.eCOBIS.Commons.COBISViewResizer
    Friend WithEvents COBISStyleProvider As COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider
    Public WithEvents COBISResourceProvider As COBISCorp.Framework.UI.Components.COBISResourceProvider
    Public ToolTip1 As System.Windows.Forms.ToolTip
    Public WithEvents txtCheque As System.Windows.Forms.TextBox
    Public WithEvents txtCarta As System.Windows.Forms.TextBox
    Public WithEvents txtRemesa As System.Windows.Forms.TextBox
    Public WithEvents txtCtaGirada As System.Windows.Forms.TextBox
    Public WithEvents mskCuenta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _lblEtiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Public WithEvents SSFrame1 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Public cmdBoton(1) As System.Windows.Forms.Button
	Public lblEtiqueta(5) As System.Windows.Forms.Label
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FAcuseChqClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.SSFrame1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.txtCheque = New System.Windows.Forms.TextBox()
        Me.txtCarta = New System.Windows.Forms.TextBox()
        Me.txtRemesa = New System.Windows.Forms.TextBox()
        Me.txtCtaGirada = New System.Windows.Forms.TextBox()
        Me.mskCuenta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._lblEtiqueta_5 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBCancelar = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        Me.mskValor = New COBISCorp.Framework.UI.Components.CobisRealInput()
        CType(Me.SSFrame1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SSFrame1.SuspendLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        Me.TSBotones.SuspendLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'COBISViewResizer
        '
        Me.COBISViewResizer.AutoRelocateControls = False
        Me.COBISViewResizer.AutoResizeControls = False
        Me.COBISViewResizer.ContainerForm = Me
        '
        'SSFrame1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.SSFrame1, False)
        Me.COBISViewResizer.SetAutoResize(Me.SSFrame1, False)
        Me.SSFrame1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.SSFrame1.Controls.Add(Me.mskValor)
        Me.SSFrame1.Controls.Add(Me.txtCheque)
        Me.SSFrame1.Controls.Add(Me.txtCarta)
        Me.SSFrame1.Controls.Add(Me.txtRemesa)
        Me.SSFrame1.Controls.Add(Me.txtCtaGirada)
        Me.SSFrame1.Controls.Add(Me.mskCuenta)
        Me.SSFrame1.Controls.Add(Me._lblEtiqueta_5)
        Me.SSFrame1.Controls.Add(Me._lblEtiqueta_4)
        Me.SSFrame1.Controls.Add(Me._lblEtiqueta_0)
        Me.SSFrame1.Controls.Add(Me._lblEtiqueta_1)
        Me.SSFrame1.Controls.Add(Me._lblEtiqueta_3)
        Me.SSFrame1.Controls.Add(Me._lblEtiqueta_2)
        Me.COBISStyleProvider.SetControlStyle(Me.SSFrame1, "Default")
        Me.SSFrame1.ForeColor = System.Drawing.Color.Navy
        Me.SSFrame1.Location = New System.Drawing.Point(10, 10)
        Me.SSFrame1.Name = "SSFrame1"
        Me.COBISResourceProvider.SetResourceID(Me.SSFrame1, "501525")
        Me.SSFrame1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.SSFrame1.Size = New System.Drawing.Size(462, 122)
        Me.SSFrame1.TabIndex = 7
        Me.SSFrame1.Text = "*Datos del Cheque"
        Me.SSFrame1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.SSFrame1, "")
        '
        'txtCheque
        '
        Me.txtCheque.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtCheque, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtCheque, False)
        Me.txtCheque.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtCheque, "Default")
        Me.txtCheque.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtCheque.Location = New System.Drawing.Point(344, 70)
        Me.txtCheque.MaxLength = 4
        Me.txtCheque.Name = "txtCheque"
        Me.txtCheque.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCheque.Size = New System.Drawing.Size(107, 20)
        Me.txtCheque.TabIndex = 4
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtCheque, "")
        Me.COBISViewResizer.SetxIncrement(Me.txtCheque, False)
        Me.COBISViewResizer.SetyIncrement(Me.txtCheque, False)
        '
        'txtCarta
        '
        Me.txtCarta.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtCarta, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtCarta, False)
        Me.txtCarta.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtCarta, "Default")
        Me.txtCarta.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtCarta.Location = New System.Drawing.Point(126, 24)
        Me.txtCarta.MaxLength = 6
        Me.txtCarta.Name = "txtCarta"
        Me.txtCarta.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCarta.Size = New System.Drawing.Size(107, 20)
        Me.txtCarta.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtCarta, "")
        Me.COBISViewResizer.SetxIncrement(Me.txtCarta, False)
        Me.COBISViewResizer.SetyIncrement(Me.txtCarta, False)
        '
        'txtRemesa
        '
        Me.txtRemesa.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtRemesa, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtRemesa, False)
        Me.txtRemesa.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtRemesa, "Default")
        Me.txtRemesa.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtRemesa.Location = New System.Drawing.Point(126, 47)
        Me.txtRemesa.MaxLength = 6
        Me.txtRemesa.Name = "txtRemesa"
        Me.txtRemesa.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtRemesa.Size = New System.Drawing.Size(107, 20)
        Me.txtRemesa.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtRemesa, "")
        Me.COBISViewResizer.SetxIncrement(Me.txtRemesa, False)
        Me.COBISViewResizer.SetyIncrement(Me.txtRemesa, False)
        '
        'txtCtaGirada
        '
        Me.txtCtaGirada.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtCtaGirada, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtCtaGirada, False)
        Me.txtCtaGirada.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtCtaGirada, "Default")
        Me.txtCtaGirada.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtCtaGirada.Location = New System.Drawing.Point(126, 93)
        Me.txtCtaGirada.MaxLength = 14
        Me.txtCtaGirada.Name = "txtCtaGirada"
        Me.txtCtaGirada.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCtaGirada.Size = New System.Drawing.Size(107, 20)
        Me.txtCtaGirada.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtCtaGirada, "")
        Me.COBISViewResizer.SetxIncrement(Me.txtCtaGirada, False)
        Me.COBISViewResizer.SetyIncrement(Me.txtCtaGirada, False)
        '
        'mskCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuenta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuenta, "Default")
        Me.mskCuenta.Length = CType(64, Short)
        Me.mskCuenta.Location = New System.Drawing.Point(126, 70)
        Me.mskCuenta.Mask = "####-##-#####-#"
        Me.mskCuenta.MaxReal = 3.402823E+38!
        Me.mskCuenta.MinReal = -3.402823E+38!
        Me.mskCuenta.Name = "mskCuenta"
        Me.mskCuenta.Size = New System.Drawing.Size(107, 20)
        Me.mskCuenta.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuenta, "")
        '
        '_lblEtiqueta_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_5, False)
        Me._lblEtiqueta_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_5, "Default")
        Me._lblEtiqueta_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_5.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_5.Location = New System.Drawing.Point(266, 93)
        Me._lblEtiqueta_5.Name = "_lblEtiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_5, "500030")
        Me._lblEtiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_5.Size = New System.Drawing.Size(39, 20)
        Me._lblEtiqueta_5.TabIndex = 14
        Me._lblEtiqueta_5.Text = "*Valor:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_5, "")
        '
        '_lblEtiqueta_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_4, False)
        Me._lblEtiqueta_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_4, "Default")
        Me._lblEtiqueta_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_4.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_4.Location = New System.Drawing.Point(265, 70)
        Me._lblEtiqueta_4.Name = "_lblEtiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_4, "2507")
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(77, 20)
        Me._lblEtiqueta_4.TabIndex = 13
        Me._lblEtiqueta_4.Text = "*No. Cheque:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_4, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 24)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "500300")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(81, 20)
        Me._lblEtiqueta_0.TabIndex = 12
        Me._lblEtiqueta_0.Text = "*No. de carta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(10, 47)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "2505")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(79, 20)
        Me._lblEtiqueta_1.TabIndex = 11
        Me._lblEtiqueta_1.Text = "*No. Remesa:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_lblEtiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(10, 70)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "501571")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(118, 20)
        Me._lblEtiqueta_3.TabIndex = 10
        Me._lblEtiqueta_3.Text = "*Cuenta Depositada:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        '_lblEtiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_2, False)
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(10, 93)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "2506")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(74, 20)
        Me._lblEtiqueta_2.TabIndex = 9
        Me._lblEtiqueta_2.Text = "*Cta. Girada:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        '_cmdBoton_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_1, False)
        Me._cmdBoton_1.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_1, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_1, True)
        Me._cmdBoton_1.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_1, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_1, Nothing)
        Me._cmdBoton_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_1.Location = New System.Drawing.Point(-428, 158)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 8
        Me._cmdBoton_1.Text = "*&Cancelar"
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
        '
        '_cmdBoton_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_0, False)
        Me._cmdBoton_0.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_0, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_0, True)
        Me._cmdBoton_0.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_0, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_0, Nothing)
        Me._cmdBoton_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_0.Location = New System.Drawing.Point(-340, 158)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 6
        Me._cmdBoton_0.Text = "*&Transmitir"
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.SSFrame1)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(478, 142)
        Me.PFormas.TabIndex = 10
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        Me.COBISViewResizer.SetxIncrement(Me.PFormas, False)
        Me.COBISViewResizer.SetyIncrement(Me.PFormas, False)
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBTransmitir, Me.TSBCancelar})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(516, 25)
        Me.TSBotones.TabIndex = 11
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.ForeColor = System.Drawing.Color.Navy
        Me.TSBTransmitir.Image = CType(resources.GetObject("TSBTransmitir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBTransmitir.Name = "TSBTransmitir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.Size = New System.Drawing.Size(86, 22)
        Me.TSBTransmitir.Text = "*&Transmitir"
        '
        'TSBCancelar
        '
        Me.TSBCancelar.ForeColor = System.Drawing.Color.Navy
        Me.TSBCancelar.Image = CType(resources.GetObject("TSBCancelar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBCancelar, "2023")
        Me.TSBCancelar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBCancelar.Name = "TSBCancelar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBCancelar, "2012")
        Me.TSBCancelar.Size = New System.Drawing.Size(78, 22)
        Me.TSBCancelar.Text = "*&Cancelar"
        '
        'mskValor
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskValor, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskValor, False)
        Me.mskValor.BackColor = System.Drawing.SystemColors.Window
        Me.mskValor.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me.mskValor, "Default")
        Me.mskValor.DecimalPlaces = 2
        Me.mskValor.Location = New System.Drawing.Point(344, 91)
        Me.mskValor.MaxLength = 15
        Me.mskValor.MaxReal = 3.4E+38!
        Me.mskValor.MinReal = 0.0!
        Me.mskValor.Name = "mskValor"
        Me.mskValor.Separator = True
        Me.mskValor.Size = New System.Drawing.Size(107, 20)
        Me.mskValor.TabIndex = 60
        Me.mskValor.Text = "0.00"
        Me.mskValor.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me.mskValor.ValueDouble = 0.0R
        Me.mskValor.ValueReal = 0.0!
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskValor, "")
        '
        'FAcuseChqClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Location = New System.Drawing.Point(4, 23)
        Me.Name = "FAcuseChqClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(516, 216)
        Me.Tag = "3881"
        Me.Text = "Acuse de Novedad"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        Me.COBISViewResizer.SetxIncrement(Me, False)
        Me.COBISViewResizer.SetyIncrement(Me, False)
        CType(Me.SSFrame1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.SSFrame1.ResumeLayout(False)
        Me.SSFrame1.PerformLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(5) = _lblEtiqueta_5
        Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(0) = _lblEtiqueta_0
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(2) = _lblEtiqueta_2
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(0) = _cmdBoton_0
    End Sub
    'Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBCancelar As System.Windows.Forms.ToolStripButton
    Private WithEvents mskValor As COBISCorp.Framework.UI.Components.CobisRealInput
#End Region 
End Class


