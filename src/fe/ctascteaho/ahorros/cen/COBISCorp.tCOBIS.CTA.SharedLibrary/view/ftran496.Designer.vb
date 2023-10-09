<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class ftran496Class
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
		InitializetxtCampo()
		InitializelblEtiqueta()
		InitializelblDescripcion()
		InitializecmdBoton()
        'InitializeLine1()
		'This form is an MDI child.
		'This code simulates the Compatibility.VB6 
		' functionality of automatically
		' loading and showing an MDI
		' child's parent.
		'The MDI form in the Compatibility.VB6 project had its
		'AutoShowChildren property set to True
		'To simulate the Compatibility.VB6 behavior, we need to
		'automatically Show the form whenever it
		'is loaded.  If you do not want this behavior
		'then delete the following line of code
		'UPGRADE_TODO: (2018) Remove the next line of code to stop form from automatically showing. More Information: http://www.vbtonet.com/ewis/ewi2018.aspx
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
    Private WithEvents _txtCampo_1 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_0 As System.Windows.Forms.TextBox
    Public WithEvents mskValor As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Public WithEvents Maskpropios As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Public WithEvents MaskObancos As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Public WithEvents MaskExt As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_8 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_7 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Public WithEvents frmCheques As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents mskCuenta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Public WithEvents grdPropietarios As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Public Line1(2) As System.Windows.Forms.Label
	Public cmdBoton(3) As System.Windows.Forms.Button
	Public lblDescripcion(0) As System.Windows.Forms.Label
	Public lblEtiqueta(8) As System.Windows.Forms.Label
	Public txtCampo(1) As System.Windows.Forms.TextBox
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(ftran496Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.frmCheques = New Infragistics.Win.Misc.UltraGroupBox()
        Me._txtCampo_1 = New System.Windows.Forms.TextBox()
        Me._txtCampo_0 = New System.Windows.Forms.TextBox()
        Me.mskValor = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.Maskpropios = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.MaskObancos = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.MaskExt = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_8 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_7 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_5 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me.mskCuenta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me.grdPropietarios = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBPropietarios = New System.Windows.Forms.ToolStripButton()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.frmCheques, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.frmCheques.SuspendLayout()
        CType(Me.grdPropietarios, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
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
        Me.COBISViewResizer.EnabledResize = True
        '
        'frmCheques
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.frmCheques, False)
        Me.COBISViewResizer.SetAutoResize(Me.frmCheques, False)
        Me.frmCheques.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.frmCheques.Controls.Add(Me._txtCampo_1)
        Me.frmCheques.Controls.Add(Me._txtCampo_0)
        Me.frmCheques.Controls.Add(Me.mskValor)
        Me.frmCheques.Controls.Add(Me.Maskpropios)
        Me.frmCheques.Controls.Add(Me.MaskObancos)
        Me.frmCheques.Controls.Add(Me.MaskExt)
        Me.frmCheques.Controls.Add(Me._lblEtiqueta_1)
        Me.frmCheques.Controls.Add(Me._lblEtiqueta_8)
        Me.frmCheques.Controls.Add(Me._lblEtiqueta_7)
        Me.frmCheques.Controls.Add(Me._lblEtiqueta_2)
        Me.frmCheques.Controls.Add(Me._lblEtiqueta_5)
        Me.frmCheques.Controls.Add(Me._lblEtiqueta_3)
        Me.COBISStyleProvider.SetControlStyle(Me.frmCheques, "Default")
        Me.frmCheques.ForeColor = System.Drawing.Color.Navy
        Me.frmCheques.Location = New System.Drawing.Point(10, 189)
        Me.frmCheques.Name = "frmCheques"
        Me.COBISResourceProvider.SetResourceID(Me.frmCheques, "501342")
        Me.frmCheques.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.frmCheques.Size = New System.Drawing.Size(566, 167)
        Me.frmCheques.TabIndex = 0
        Me.frmCheques.Text = "*Datos del Depósito"
        Me.frmCheques.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.frmCheques, "")
        '
        '_txtCampo_1
        '
        Me._txtCampo_1.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_1, False)
        Me._txtCampo_1.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_1, "Default")
        Me._txtCampo_1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_1.Location = New System.Drawing.Point(145, 134)
        Me._txtCampo_1.MaxLength = 6
        Me._txtCampo_1.Name = "_txtCampo_1"
        Me._txtCampo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_1.Size = New System.Drawing.Size(134, 20)
        Me._txtCampo_1.TabIndex = 7
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_1, "")
        '
        '_txtCampo_0
        '
        Me._txtCampo_0.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_0, False)
        Me._txtCampo_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_0, "Default")
        Me._txtCampo_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_0.Location = New System.Drawing.Point(145, 27)
        Me._txtCampo_0.MaxLength = 6
        Me._txtCampo_0.Name = "_txtCampo_0"
        Me._txtCampo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_0.Size = New System.Drawing.Size(134, 20)
        Me._txtCampo_0.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_0, "")
        '
        'mskValor
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskValor, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskValor, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskValor, "Default")
        Me.mskValor.Length = CType(64, Short)
        Me.mskValor.Location = New System.Drawing.Point(145, 49)
        Me.mskValor.MaxReal = 3.402823E+38!
        Me.mskValor.MinReal = -3.402823E+38!
        Me.mskValor.Name = "mskValor"
        Me.mskValor.Size = New System.Drawing.Size(134, 20)
        Me.mskValor.TabIndex = 3
        Me.mskValor.Text = "#,##0.00"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskValor, "")
        '
        'Maskpropios
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Maskpropios, False)
        Me.COBISViewResizer.SetAutoResize(Me.Maskpropios, False)
        Me.COBISStyleProvider.SetControlStyle(Me.Maskpropios, "Default")
        Me.Maskpropios.Length = CType(64, Short)
        Me.Maskpropios.Location = New System.Drawing.Point(145, 70)
        Me.Maskpropios.MaxReal = 3.402823E+38!
        Me.Maskpropios.MinReal = -3.402823E+38!
        Me.Maskpropios.Name = "Maskpropios"
        Me.Maskpropios.Size = New System.Drawing.Size(134, 20)
        Me.Maskpropios.TabIndex = 4
        Me.Maskpropios.Text = "#,##0.00"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Maskpropios, "")
        '
        'MaskObancos
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.MaskObancos, False)
        Me.COBISViewResizer.SetAutoResize(Me.MaskObancos, False)
        Me.COBISStyleProvider.SetControlStyle(Me.MaskObancos, "Default")
        Me.MaskObancos.Length = CType(64, Short)
        Me.MaskObancos.Location = New System.Drawing.Point(145, 91)
        Me.MaskObancos.MaxReal = 3.402823E+38!
        Me.MaskObancos.MinReal = -3.402823E+38!
        Me.MaskObancos.Name = "MaskObancos"
        Me.MaskObancos.Size = New System.Drawing.Size(134, 20)
        Me.MaskObancos.TabIndex = 5
        Me.MaskObancos.Text = "#,##0.00"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.MaskObancos, "")
        '
        'MaskExt
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.MaskExt, False)
        Me.COBISViewResizer.SetAutoResize(Me.MaskExt, False)
        Me.COBISStyleProvider.SetControlStyle(Me.MaskExt, "Default")
        Me.MaskExt.Length = CType(64, Short)
        Me.MaskExt.Location = New System.Drawing.Point(145, 112)
        Me.MaskExt.MaxReal = 3.402823E+38!
        Me.MaskExt.MinReal = -3.402823E+38!
        Me.MaskExt.Name = "MaskExt"
        Me.MaskExt.Size = New System.Drawing.Size(134, 20)
        Me.MaskExt.TabIndex = 6
        Me.MaskExt.Text = "#,##0.00"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.MaskExt, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(16, 134)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "501343")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(68, 20)
        Me._lblEtiqueta_1.TabIndex = 22
        Me._lblEtiqueta_1.Text = "*Secuencial:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_lblEtiqueta_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_8, False)
        Me._lblEtiqueta_8.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_8, "Default")
        Me._lblEtiqueta_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_8.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_8.Location = New System.Drawing.Point(16, 112)
        Me._lblEtiqueta_8.Name = "_lblEtiqueta_8"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_8, "501344")
        Me._lblEtiqueta_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_8.Size = New System.Drawing.Size(101, 20)
        Me._lblEtiqueta_8.TabIndex = 21
        Me._lblEtiqueta_8.Text = "*Cheques del Ext.:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_8, "")
        '
        '_lblEtiqueta_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_7, False)
        Me._lblEtiqueta_7.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_7, "Default")
        Me._lblEtiqueta_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_7.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_7.Location = New System.Drawing.Point(16, 91)
        Me._lblEtiqueta_7.Name = "_lblEtiqueta_7"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_7, "501345")
        Me._lblEtiqueta_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_7.Size = New System.Drawing.Size(134, 20)
        Me._lblEtiqueta_7.TabIndex = 20
        Me._lblEtiqueta_7.Text = "*Cheques Otros Bancos:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_7, "")
        '
        '_lblEtiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_2, False)
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(16, 69)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "501346")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(100, 20)
        Me._lblEtiqueta_2.TabIndex = 19
        Me._lblEtiqueta_2.Text = "*Cheques Propios:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        '_lblEtiqueta_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_5, False)
        Me._lblEtiqueta_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_5, "Default")
        Me._lblEtiqueta_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_5.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_5.Location = New System.Drawing.Point(14, 27)
        Me._lblEtiqueta_5.Name = "_lblEtiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_5, "501347")
        Me._lblEtiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_5.Size = New System.Drawing.Size(41, 20)
        Me._lblEtiqueta_5.TabIndex = 9
        Me._lblEtiqueta_5.Text = "*Boleta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_5, "")
        '
        '_lblEtiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(15, 49)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "501348")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(52, 20)
        Me._lblEtiqueta_3.TabIndex = 8
        Me._lblEtiqueta_3.Text = "*Efectivo:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        'mskCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuenta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuenta, "Default")
        Me.mskCuenta.Length = CType(64, Short)
        Me.mskCuenta.Location = New System.Drawing.Point(150, 10)
        Me.mskCuenta.MaxReal = 3.402823E+38!
        Me.mskCuenta.MinReal = -3.402823E+38!
        Me.mskCuenta.Name = "mskCuenta"
        Me.mskCuenta.Size = New System.Drawing.Size(147, 20)
        Me.mskCuenta.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuenta, "")
        '
        '_cmdBoton_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_3, False)
        Me._cmdBoton_3.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_3, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_3, True)
        Me._cmdBoton_3.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_3, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_3, Nothing)
        Me._cmdBoton_3.Enabled = False
        Me._cmdBoton_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_3.Location = New System.Drawing.Point(666, 59)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 10
        Me._cmdBoton_3.Text = "*&Propiet."
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
        '
        'grdPropietarios
        '
        Me.grdPropietarios._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdPropietarios, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdPropietarios, False)
        Me.grdPropietarios.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdPropietarios.Clip = ""
        Me.grdPropietarios.Col = CType(1, Short)
        Me.grdPropietarios.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdPropietarios.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdPropietarios.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdPropietarios, "Default")
        Me.grdPropietarios.CtlText = ""
        Me.grdPropietarios.Dock = System.Windows.Forms.DockStyle.Fill
        Me.COBISStyleProvider.SetEnableStyle(Me.grdPropietarios, True)
        Me.grdPropietarios.FixedCols = CType(1, Short)
        Me.grdPropietarios.FixedRows = CType(1, Short)
        Me.grdPropietarios.ForeColor = System.Drawing.Color.Black
        Me.grdPropietarios.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdPropietarios.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdPropietarios.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdPropietarios.HighLight = True
        Me.grdPropietarios.Location = New System.Drawing.Point(3, 16)
        Me.grdPropietarios.Name = "grdPropietarios"
        Me.grdPropietarios.Picture = Nothing
        Me.grdPropietarios.Row = CType(1, Short)
        Me.grdPropietarios.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdPropietarios.Size = New System.Drawing.Size(561, 112)
        Me.grdPropietarios.Sort = CType(2, Short)
        Me.grdPropietarios.TabIndex = 11
        Me.grdPropietarios.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdPropietarios, "")
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
        Me._cmdBoton_0.Location = New System.Drawing.Point(666, 191)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 12
        Me._cmdBoton_0.Text = "*&Transmitir"
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(666, 242)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 13
        Me._cmdBoton_1.Text = "*&Limpiar"
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
        '
        '_cmdBoton_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_2, False)
        Me._cmdBoton_2.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_2, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_2, True)
        Me._cmdBoton_2.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_2, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_2, Nothing)
        Me._cmdBoton_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_2.Location = New System.Drawing.Point(666, 293)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 14
        Me._cmdBoton_2.Text = "*&Salir"
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
        '
        '_lblDescripcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_0, False)
        Me._lblDescripcion_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_0, "Default")
        Me._lblDescripcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_0.Location = New System.Drawing.Point(150, 33)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(426, 20)
        Me._lblDescripcion_0.TabIndex = 18
        Me._lblDescripcion_0.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 10)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "500192")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(145, 20)
        Me._lblEtiqueta_0.TabIndex = 17
        Me._lblEtiqueta_0.Text = "*No. de cuenta corriente:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        '_lblEtiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_6, False)
        Me._lblEtiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_6, "Default")
        Me._lblEtiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(10, 33)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "500193")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(142, 20)
        Me._lblEtiqueta_6.TabIndex = 16
        Me._lblEtiqueta_6.Text = "*Nombre de la chequera:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdPropietarios)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 56)
        Me.GroupBox1.Name = "GroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox1, "5055")
        Me.GroupBox1.Size = New System.Drawing.Size(567, 131)
        Me.GroupBox1.TabIndex = 21
        Me.GroupBox1.Text = "*Propietarios:"
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me.frmCheques)
        Me.PFormas.Controls.Add(Me._cmdBoton_3)
        Me.PFormas.Controls.Add(Me.mskCuenta)
        Me.PFormas.Controls.Add(Me._cmdBoton_0)
        Me.PFormas.Controls.Add(Me._lblDescripcion_0)
        Me.PFormas.Controls.Add(Me._cmdBoton_1)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_0)
        Me.PFormas.Controls.Add(Me._cmdBoton_2)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_6)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(583, 361)
        Me.PFormas.TabIndex = 22
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBPropietarios, Me.TSBTransmitir, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(601, 25)
        Me.TSBotones.TabIndex = 23
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBPropietarios
        '
        Me.TSBPropietarios.ForeColor = System.Drawing.Color.Navy
        Me.TSBPropietarios.Image = CType(resources.GetObject("TSBPropietarios.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBPropietarios, "2032")
        Me.TSBPropietarios.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBPropietarios.Name = "TSBPropietarios"
        Me.COBISResourceProvider.SetResourceID(Me.TSBPropietarios, "2026")
        Me.TSBPropietarios.Size = New System.Drawing.Size(73, 22)
        Me.TSBPropietarios.Text = "*&Propiet."
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
        'TSBLimpiar
        '
        Me.TSBLimpiar.ForeColor = System.Drawing.Color.Navy
        Me.TSBLimpiar.Image = CType(resources.GetObject("TSBLimpiar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBLimpiar.Name = "TSBLimpiar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.Size = New System.Drawing.Size(72, 22)
        Me.TSBLimpiar.Text = "*&Limpiar"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.Color.Navy
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1006")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'ftran496Class
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
        Me.ForeColor = System.Drawing.SystemColors.HighlightText
        Me.Location = New System.Drawing.Point(140, 162)
        Me.Name = "ftran496Class"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(601, 402)
        Me.Text = "Deposito Monetario"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.frmCheques, System.ComponentModel.ISupportInitialize).EndInit()
        Me.frmCheques.ResumeLayout(False)
        Me.frmCheques.PerformLayout()
        CType(Me.grdPropietarios, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
	Sub InitializetxtCampo()
		Me.txtCampo(1) = _txtCampo_1
		Me.txtCampo(0) = _txtCampo_0
	End Sub
	Sub InitializelblEtiqueta()
		Me.lblEtiqueta(1) = _lblEtiqueta_1
		Me.lblEtiqueta(8) = _lblEtiqueta_8
		Me.lblEtiqueta(7) = _lblEtiqueta_7
		Me.lblEtiqueta(2) = _lblEtiqueta_2
		Me.lblEtiqueta(5) = _lblEtiqueta_5
		Me.lblEtiqueta(3) = _lblEtiqueta_3
		Me.lblEtiqueta(0) = _lblEtiqueta_0
		Me.lblEtiqueta(6) = _lblEtiqueta_6
        'Me.lblEtiqueta(4) = _lblEtiqueta_4
	End Sub
	Sub InitializelblDescripcion()
		Me.lblDescripcion(0) = _lblDescripcion_0
	End Sub
	Sub InitializecmdBoton()
		Me.cmdBoton(3) = _cmdBoton_3
		Me.cmdBoton(0) = _cmdBoton_0
		Me.cmdBoton(1) = _cmdBoton_1
		Me.cmdBoton(2) = _cmdBoton_2
	End Sub
    'Sub InitializeLine1()
    '	Me.Line1(0) = _Line1_0
    '	Me.Line1(1) = _Line1_1
    '	Me.Line1(2) = _Line1_2
    '   End Sub
    'Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBPropietarios As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
#End Region 
End Class


