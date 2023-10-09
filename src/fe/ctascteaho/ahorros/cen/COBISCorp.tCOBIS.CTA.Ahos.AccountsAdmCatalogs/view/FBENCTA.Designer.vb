Imports COBISCorp.tCOBIS.TADMIN.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FBenCtaClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
		InitializelblEtiqueta()
		InitializecmdBoton()
		InitializeSSPCta()
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
	Private WithEvents _SSPCta_0 As COBISCorp.Framework.UI.Components.COBISPanel
	Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
	Public WithEvents txtPctje As System.Windows.Forms.TextBox
	Public WithEvents txtNombre As System.Windows.Forms.TextBox
	Public WithEvents txtCed As System.Windows.Forms.TextBox
	Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
	Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
	Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
	Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
	Public WithEvents frnBeneficiario As Infragistics.Win.Misc.UltraGroupBox
	Public WithEvents grdBeneficiarios As COBISCorp.Framework.UI.Components.COBISGrid
	Private WithEvents _SSPCta_1 As COBISCorp.Framework.UI.Components.COBISPanel
	Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
	Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
	Public SSPCta(1) As COBISCorp.Framework.UI.Components.COBISPanel
	Public cmdBoton(4) As System.Windows.Forms.Button
	Public lblEtiqueta(3) As System.Windows.Forms.Label
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FBenCtaClass))
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me._SSPCta_0 = New COBISCorp.Framework.UI.Components.COBISPanel
        Me.frnBeneficiario = New Infragistics.Win.Misc.UltraGroupBox
        Me._cmdBoton_0 = New System.Windows.Forms.Button
        Me.txtPctje = New System.Windows.Forms.TextBox
        Me.txtNombre = New System.Windows.Forms.TextBox
        Me.txtCed = New System.Windows.Forms.TextBox
        Me._cmdBoton_1 = New System.Windows.Forms.Button
        Me._cmdBoton_2 = New System.Windows.Forms.Button
        Me._cmdBoton_3 = New System.Windows.Forms.Button
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label
        Me.grdBeneficiarios = New COBISCorp.Framework.UI.Components.COBISGrid
        Me._SSPCta_1 = New COBISCorp.Framework.UI.Components.COBISPanel
        Me._cmdBoton_4 = New System.Windows.Forms.Button
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox
        Me.TSBotones = New System.Windows.Forms.ToolStrip
        Me.TSBAgregar = New System.Windows.Forms.ToolStripButton
        Me.TSBModificar = New System.Windows.Forms.ToolStripButton
        Me.TSBEliminar = New System.Windows.Forms.ToolStripButton
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton
        Me.frnBeneficiario.SuspendLayout()
        CType(Me.grdBeneficiarios, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        Me.GroupBox1.SuspendLayout()
        Me.TSBotones.SuspendLayout()
        Me.Pforma = New Infragistics.Win.Misc.UltraGroupBox
        CType(Me.Pforma, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Pforma.SuspendLayout()
        Me.SuspendLayout()
        Me.COBISViewResizer.ContainerForm = Me
        '
        'Pforma
        '
        Me.Pforma.Controls.Add(Me.TSBotones)
        Me.Pforma.Controls.Add(Me.PFormas)
        Me.Pforma.Location = New System.Drawing.Point(0, 0)
        Me.Pforma.Name = "Pforma"
        Me.Pforma.Size = New System.Drawing.Size(457, 342)
        Me.Pforma.TabIndex = 0
        Me.Pforma.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        '
        'COBISResourceProvider
        '
        Me.COBISResourceProvider.SetImageID(Me.COBISResourceProvider, "")
        Me.COBISResourceProvider.SetResourceID(Me.COBISResourceProvider, "")
        '
        'ToolTip1
        '
        Me.COBISResourceProvider.SetImageID(Me.ToolTip1, "")
        Me.COBISResourceProvider.SetResourceID(Me.ToolTip1, "")
        '
        '_SSPCta_0
        '
        Me._SSPCta_0.BackColor = System.Drawing.SystemColors.Control
        Me._SSPCta_0.FloodColor = System.Drawing.Color.Empty
        Me._SSPCta_0.FloodPercent = CType(0, Short)
        Me.COBISResourceProvider.SetImageID(Me._SSPCta_0, "")
        Me._SSPCta_0.Location = New System.Drawing.Point(47, 10)
        Me._SSPCta_0.Name = "_SSPCta_0"
        Me.COBISResourceProvider.SetResourceID(Me._SSPCta_0, "")
        Me._SSPCta_0.Size = New System.Drawing.Size(105, 20)
        Me._SSPCta_0.TabIndex = 12
        Me._SSPCta_0.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'frnBeneficiario
        '
        Me.frnBeneficiario.BackColor = System.Drawing.Color.FromArgb(205,222,240)
        Me.frnBeneficiario.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.frnBeneficiario.Controls.Add(Me._cmdBoton_0)
        Me.frnBeneficiario.Controls.Add(Me.txtPctje)
        Me.frnBeneficiario.Controls.Add(Me.txtNombre)
        Me.frnBeneficiario.Controls.Add(Me.txtCed)
        Me.frnBeneficiario.Controls.Add(Me._cmdBoton_1)
        Me.frnBeneficiario.Controls.Add(Me._cmdBoton_2)
        Me.frnBeneficiario.Controls.Add(Me._cmdBoton_3)
        Me.frnBeneficiario.Controls.Add(Me._lblEtiqueta_3)
        Me.frnBeneficiario.Controls.Add(Me._lblEtiqueta_2)
        Me.frnBeneficiario.Controls.Add(Me._lblEtiqueta_1)
        Me.frnBeneficiario.ForeColor = System.Drawing.Color.Navy
        Me.COBISResourceProvider.SetImageID(Me.frnBeneficiario, "")
        Me.frnBeneficiario.Location = New System.Drawing.Point(10, 33)
        Me.frnBeneficiario.Name = "frnBeneficiario"
        Me.COBISResourceProvider.SetResourceID(Me.frnBeneficiario, "")
        Me.frnBeneficiario.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.frnBeneficiario.Size = New System.Drawing.Size(408, 80)
        Me.frnBeneficiario.TabIndex = 8
        Me.frnBeneficiario.TabStop = False
        Me.frnBeneficiario.Text = "Beneficiario"
        Me.frnBeneficiario.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        '
        '_cmdBoton_0
        '
        Me._cmdBoton_0.BackColor = System.Drawing.SystemColors.Control
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_0, True)
        Me._cmdBoton_0.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_0, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_0, Nothing)
        Me._cmdBoton_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.COBISResourceProvider.SetImageID(Me._cmdBoton_0, "")
        Me._cmdBoton_0.Location = New System.Drawing.Point(-176, 56)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me.COBISResourceProvider.SetResourceID(Me._cmdBoton_0, "")
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(73, 23)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 3
        Me._cmdBoton_0.Text = "Agregar"
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        '
        'txtPctje
        '
        Me.txtPctje.AcceptsReturn = True
        Me.txtPctje.BackColor = System.Drawing.SystemColors.Window
        Me.txtPctje.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.COBISResourceProvider.SetImageID(Me.txtPctje, "")
        Me.txtPctje.Location = New System.Drawing.Point(328, 32)
        Me.txtPctje.MaxLength = 5
        Me.txtPctje.Name = "txtPctje"
        Me.COBISResourceProvider.SetResourceID(Me.txtPctje, "")
        Me.txtPctje.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtPctje.Size = New System.Drawing.Size(49, 20)
        Me.txtPctje.TabIndex = 2
        '
        'txtNombre
        '
        Me.txtNombre.AcceptsReturn = True
        Me.txtNombre.BackColor = System.Drawing.SystemColors.Window
        Me.txtNombre.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.COBISResourceProvider.SetImageID(Me.txtNombre, "")
        Me.txtNombre.Location = New System.Drawing.Point(96, 32)
        Me.txtNombre.MaxLength = 64
        Me.txtNombre.Name = "txtNombre"
        Me.COBISResourceProvider.SetResourceID(Me.txtNombre, "")
        Me.txtNombre.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtNombre.Size = New System.Drawing.Size(233, 20)
        Me.txtNombre.TabIndex = 1
        '
        'txtCed
        '
        Me.txtCed.AcceptsReturn = True
        Me.txtCed.BackColor = System.Drawing.SystemColors.Window
        Me.txtCed.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.COBISResourceProvider.SetImageID(Me.txtCed, "")
        Me.txtCed.Location = New System.Drawing.Point(8, 32)
        Me.txtCed.MaxLength = 20
        Me.txtCed.Name = "txtCed"
        Me.COBISResourceProvider.SetResourceID(Me.txtCed, "")
        Me.txtCed.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCed.Size = New System.Drawing.Size(89, 20)
        Me.txtCed.TabIndex = 0
        '
        '_cmdBoton_1
        '
        Me._cmdBoton_1.BackColor = System.Drawing.SystemColors.Control
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_1, True)
        Me._cmdBoton_1.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_1, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_1, Nothing)
        Me._cmdBoton_1.Enabled = False
        Me._cmdBoton_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.COBISResourceProvider.SetImageID(Me._cmdBoton_1, "")
        Me._cmdBoton_1.Location = New System.Drawing.Point(-252, 56)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me.COBISResourceProvider.SetResourceID(Me._cmdBoton_1, "")
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(73, 23)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 5
        Me._cmdBoton_1.Text = "Modificar"
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        '
        '_cmdBoton_2
        '
        Me._cmdBoton_2.BackColor = System.Drawing.SystemColors.Control
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_2, True)
        Me._cmdBoton_2.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_2, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_2, Nothing)
        Me._cmdBoton_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.COBISResourceProvider.SetImageID(Me._cmdBoton_2, "")
        Me._cmdBoton_2.Location = New System.Drawing.Point(-328, 56)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me.COBISResourceProvider.SetResourceID(Me._cmdBoton_2, "")
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(73, 23)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 6
        Me._cmdBoton_2.Text = "Eliminar"
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        '
        '_cmdBoton_3
        '
        Me._cmdBoton_3.BackColor = System.Drawing.SystemColors.Control
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_3, True)
        Me._cmdBoton_3.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_3, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_3, Nothing)
        Me._cmdBoton_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.COBISResourceProvider.SetImageID(Me._cmdBoton_3, "")
        Me._cmdBoton_3.Location = New System.Drawing.Point(378, 32)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me.COBISResourceProvider.SetResourceID(Me._cmdBoton_3, "")
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(24, 23)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 14
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        '
        '_lblEtiqueta_3
        '
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me._lblEtiqueta_3.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me.COBISResourceProvider.SetImageID(Me._lblEtiqueta_3, "")
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(328, 16)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(16, 20)
        Me._lblEtiqueta_3.TabIndex = 11
        Me._lblEtiqueta_3.Text = "%"
        '
        '_lblEtiqueta_2
        '
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me._lblEtiqueta_2.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me.COBISResourceProvider.SetImageID(Me._lblEtiqueta_2, "")
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(96, 16)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(59, 20)
        Me._lblEtiqueta_2.TabIndex = 10
        Me._lblEtiqueta_2.Text = "Nombre"
        '
        '_lblEtiqueta_1
        '
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me._lblEtiqueta_1.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me.COBISResourceProvider.SetImageID(Me._lblEtiqueta_1, "")
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(8, 16)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(89, 20)
        Me._lblEtiqueta_1.TabIndex = 9
        Me._lblEtiqueta_1.Text = "Ced/NIT/Pas"
        '
        'grdBeneficiarios
        '
        Me.grdBeneficiarios._Text = ""
        Me.grdBeneficiarios.BackgroundColor = System.Drawing.Color.FromArgb(240,246,250)
        Me.grdBeneficiarios.Clip = ""
        Me.grdBeneficiarios.Col = CType(1, Short)
        Me.grdBeneficiarios.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdBeneficiarios.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdBeneficiarios.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.grdBeneficiarios.CtlText = ""
        Me.grdBeneficiarios.FixedCols = CType(1, Short)
        Me.grdBeneficiarios.FixedRows = CType(1, Short)
        Me.grdBeneficiarios.ForeColor = System.Drawing.Color.Black
        Me.grdBeneficiarios.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdBeneficiarios.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdBeneficiarios.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdBeneficiarios.HighLight = True
        Me.COBISResourceProvider.SetImageID(Me.grdBeneficiarios, "")
        Me.grdBeneficiarios.Location = New System.Drawing.Point(3, 14)
        Me.grdBeneficiarios.Name = "grdBeneficiarios"
        Me.grdBeneficiarios.Picture = Nothing
        Me.COBISResourceProvider.SetResourceID(Me.grdBeneficiarios, "")
        Me.grdBeneficiarios.Row = CType(1, Short)
        Me.grdBeneficiarios.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdBeneficiarios.Size = New System.Drawing.Size(408, 151)
        Me.grdBeneficiarios.Sort = CType(2, Short)
        Me.grdBeneficiarios.TabIndex = 4
        Me.grdBeneficiarios.TopRow = CType(1, Short)
        '
        '_SSPCta_1
        '
        Me._SSPCta_1.BackColor = System.Drawing.SystemColors.Control
        Me._SSPCta_1.FloodColor = System.Drawing.Color.Empty
        Me._SSPCta_1.FloodPercent = CType(0, Short)
        Me.COBISResourceProvider.SetImageID(Me._SSPCta_1, "")
        Me._SSPCta_1.Location = New System.Drawing.Point(153, 10)
        Me._SSPCta_1.Name = "_SSPCta_1"
        Me.COBISResourceProvider.SetResourceID(Me._SSPCta_1, "")
        Me._SSPCta_1.Size = New System.Drawing.Size(260, 20)
        Me._SSPCta_1.TabIndex = 13
        Me._SSPCta_1.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        '_cmdBoton_4
        '
        Me._cmdBoton_4.BackColor = System.Drawing.SystemColors.Control
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_4, True)
        Me._cmdBoton_4.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_4, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_4, Nothing)
        Me._cmdBoton_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.COBISResourceProvider.SetImageID(Me._cmdBoton_4, "")
        Me._cmdBoton_4.Location = New System.Drawing.Point(-351, 260)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me.COBISResourceProvider.SetResourceID(Me._cmdBoton_4, "")
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(63, 23)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 15
        Me._cmdBoton_4.Text = "Salir"
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        '
        '_lblEtiqueta_0
        '
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me._lblEtiqueta_0.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me.COBISResourceProvider.SetImageID(Me._lblEtiqueta_0, "")
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 10)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(31, 20)
        Me._lblEtiqueta_0.TabIndex = 7
        Me._lblEtiqueta_0.Text = "Cta: "
        '
        'commandButtonHelper1
        '
        Me.COBISResourceProvider.SetImageID(Me.commandButtonHelper1, "")
        Me.COBISResourceProvider.SetResourceID(Me.commandButtonHelper1, "")
        '
        'PFormas
        '
        Me.PFormas.BackColor = System.Drawing.Color.White
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me._SSPCta_0)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_0)
        Me.PFormas.Controls.Add(Me.frnBeneficiario)
        Me.PFormas.Controls.Add(Me._cmdBoton_4)
        Me.PFormas.Controls.Add(Me._SSPCta_1)
        Me.COBISResourceProvider.SetImageID(Me.PFormas, "")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.COBISResourceProvider.SetResourceID(Me.PFormas, "")
        Me.PFormas.Size = New System.Drawing.Size(436, 296)
        Me.PFormas.TabIndex = 16
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        '
        'GroupBox1
        '
        Me.GroupBox1.Controls.Add(Me.grdBeneficiarios)
        Me.GroupBox1.BackColor = System.Drawing.Color.FromArgb(205,222,240)
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.COBISResourceProvider.SetImageID(Me.GroupBox1, "")
        Me.GroupBox1.Location = New System.Drawing.Point(10, 114)
        Me.GroupBox1.Name = "GroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox1, "")
        Me.GroupBox1.Size = New System.Drawing.Size(417, 174)
        Me.GroupBox1.TabIndex = 16
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        '
        'TSBotones
        '
        Me.COBISResourceProvider.SetImageID(Me.TSBotones, "")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBAgregar, Me.TSBModificar, Me.TSBEliminar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.COBISResourceProvider.SetResourceID(Me.TSBotones, "")
        Me.TSBotones.Size = New System.Drawing.Size(454, 25)
        Me.TSBotones.TabIndex = 17
        Me.TSBotones.Text = "ToolStrip1"
        '
        'TSBAgregar
        '
        Me.TSBAgregar.ForeColor = System.Drawing.Color.Navy
        Me.TSBAgregar.Image = CType(resources.GetObject("TSBAgregar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBAgregar, "")
        Me.TSBAgregar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBAgregar.Name = "TSBAgregar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBAgregar, "")
        Me.TSBAgregar.Size = New System.Drawing.Size(74, 22)
        Me.TSBAgregar.Text = "*&Agregar"
        '
        'TSBModificar
        '
        Me.TSBModificar.ForeColor = System.Drawing.Color.Navy
        Me.TSBModificar.Image = CType(resources.GetObject("TSBModificar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBModificar, "")
        Me.TSBModificar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBModificar.Name = "TSBModificar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBModificar, "")
        Me.TSBModificar.Size = New System.Drawing.Size(83, 22)
        Me.TSBModificar.Text = "*&Modificar"
        '
        'TSBEliminar
        '
        Me.TSBEliminar.ForeColor = System.Drawing.Color.Navy
        Me.TSBEliminar.Image = CType(resources.GetObject("TSBEliminar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEliminar, "")
        Me.TSBEliminar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEliminar.Name = "TSBEliminar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEliminar, "")
        Me.TSBEliminar.Size = New System.Drawing.Size(75, 22)
        Me.TSBEliminar.Text = "*&Eliminar"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.Color.Navy
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'FBenCta
        '
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.ClientSize = New System.Drawing.Size(454, 344)
        Me.Controls.Add(Me.Pforma)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.COBISResourceProvider.SetImageID(Me, "")
        Me.Location = New System.Drawing.Point(6, 106)
        Me.Name = "FBenCta"
        Me.COBISResourceProvider.SetResourceID(Me, "")
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Text = "Beneficiarios de una Cuenta"
        Me.frnBeneficiario.ResumeLayout(False)
        Me.frnBeneficiario.PerformLayout()
        CType(Me.grdBeneficiarios, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.GroupBox1.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.Pforma, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Pforma.ResumeLayout(False)
        Me.Pforma.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(0) = _lblEtiqueta_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(4) = _cmdBoton_4
    End Sub
    Sub InitializeSSPCta()
        Me.SSPCta(0) = _SSPCta_0
        Me.SSPCta(1) = _SSPCta_1
    End Sub
    Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBAgregar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBModificar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEliminar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
#End Region 
End Class


