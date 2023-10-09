Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FTran099Class
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		isInitializingComponent = True
		InitializeComponent()
		isInitializingComponent = False
		InitializetxtCampo()
		InitializepicVisto()
		InitializemskValor()
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
    Private WithEvents _txtCampo_7 As System.Windows.Forms.TextBox
    Private WithEvents _picVisto_0 As System.Windows.Forms.PictureBox
    Private WithEvents _picVisto_1 As System.Windows.Forms.PictureBox
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Public WithEvents grdOficinas As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmdBoton_5 As System.Windows.Forms.Button
    Public WithEvents cmbProducto As System.Windows.Forms.ComboBox
    Private WithEvents _txtCampo_6 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_5 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_4 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_3 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_1 As System.Windows.Forms.TextBox
    Private WithEvents _mskValor_0 As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _txtCampo_2 As System.Windows.Forms.TextBox
    Private WithEvents _mskValor_1 As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _lblEtiqueta_9 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_8 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_7 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Public WithEvents frmBloqueo As Infragistics.Win.Misc.UltraGroupBox
    Public Line1(2) As System.Windows.Forms.Label
    Public cmdBoton(5) As System.Windows.Forms.Button
    Public lblDescripcion(0) As System.Windows.Forms.Label
    Public lblEtiqueta(9) As System.Windows.Forms.Label
    Public mskValor(1) As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Public picVisto(1) As System.Windows.Forms.PictureBox
    Public txtCampo(7) As System.Windows.Forms.TextBox
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
     Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FTran099Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me._txtCampo_7 = New System.Windows.Forms.TextBox()
        Me._picVisto_0 = New System.Windows.Forms.PictureBox()
        Me._picVisto_1 = New System.Windows.Forms.PictureBox()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me.grdOficinas = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._cmdBoton_5 = New System.Windows.Forms.Button()
        Me.frmBloqueo = New Infragistics.Win.Misc.UltraGroupBox()
        Me.cmbProducto = New System.Windows.Forms.ComboBox()
        Me._txtCampo_6 = New System.Windows.Forms.TextBox()
        Me._txtCampo_5 = New System.Windows.Forms.TextBox()
        Me._txtCampo_4 = New System.Windows.Forms.TextBox()
        Me._txtCampo_3 = New System.Windows.Forms.TextBox()
        Me._txtCampo_1 = New System.Windows.Forms.TextBox()
        Me._mskValor_0 = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._txtCampo_2 = New System.Windows.Forms.TextBox()
        Me._mskValor_1 = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._lblEtiqueta_9 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_8 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_7 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_5 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.grdPropietarios = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.TSBBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBEliminar = New System.Windows.Forms.ToolStripButton()
        Me.TSBActualizar = New System.Windows.Forms.ToolStripButton()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        Me.GroupBox1 = New System.Windows.Forms.GroupBox()
        CType(Me._picVisto_0, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me._picVisto_1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.grdOficinas, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.frmBloqueo, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.frmBloqueo.SuspendLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.grdPropietarios, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.TSBBotones.SuspendLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
        Me.SuspendLayout()
        '
        'COBISViewResizer
        '
        Me.COBISViewResizer.AutoRelocateControls = False
        Me.COBISViewResizer.AutoResizeControls = False
        Me.COBISViewResizer.ContainerForm = Me
        Me.COBISViewResizer.EnabledResize = True
        '
        '_txtCampo_7
        '
        Me._txtCampo_7.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_7, False)
        Me._txtCampo_7.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_7, "Default")
        Me._txtCampo_7.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_7.Location = New System.Drawing.Point(74, 205)
        Me._txtCampo_7.MaxLength = 79
        Me._txtCampo_7.Name = "_txtCampo_7"
        Me._txtCampo_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_7.Size = New System.Drawing.Size(480, 20)
        Me._txtCampo_7.TabIndex = 9
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_7, "")
        '
        '_picVisto_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._picVisto_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._picVisto_0, False)
        Me._picVisto_0.BackColor = System.Drawing.Color.Gray
        Me._picVisto_0.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._picVisto_0, "Default")
        Me._picVisto_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._picVisto_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._picVisto_0.Image = CType(resources.GetObject("_picVisto_0.Image"), System.Drawing.Image)
        Me._picVisto_0.Location = New System.Drawing.Point(689, 147)
        Me._picVisto_0.Name = "_picVisto_0"
        Me._picVisto_0.Size = New System.Drawing.Size(13, 13)
        Me._picVisto_0.TabIndex = 24
        Me._picVisto_0.TabStop = False
        Me._picVisto_0.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._picVisto_0, "")
        '
        '_picVisto_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._picVisto_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._picVisto_1, False)
        Me._picVisto_1.BackColor = System.Drawing.Color.Silver
        Me._picVisto_1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._picVisto_1, "Default")
        Me._picVisto_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._picVisto_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._picVisto_1.Location = New System.Drawing.Point(707, 147)
        Me._picVisto_1.Name = "_picVisto_1"
        Me._picVisto_1.Size = New System.Drawing.Size(13, 13)
        Me._picVisto_1.TabIndex = 23
        Me._picVisto_1.TabStop = False
        Me._picVisto_1.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._picVisto_1, "")
        '
        '_cmdBoton_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_4, False)
        Me._cmdBoton_4.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_4, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_4, True)
        Me._cmdBoton_4.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_4, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_4, Nothing)
        Me._cmdBoton_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_4.Location = New System.Drawing.Point(689, 91)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 11
        Me._cmdBoton_4.TabStop = False
        Me._cmdBoton_4.Text = "*&Eliminar"
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
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
        Me._cmdBoton_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_3.Location = New System.Drawing.Point(689, 40)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 10
        Me._cmdBoton_3.TabStop = False
        Me._cmdBoton_3.Text = "*&Buscar"
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
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
        Me._cmdBoton_2.Location = New System.Drawing.Point(689, 374)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 14
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Text = "*&Salir"
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(689, 323)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 13
        Me._cmdBoton_1.TabStop = False
        Me._cmdBoton_1.Text = "*&Limpiar"
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
        Me._cmdBoton_0.Location = New System.Drawing.Point(689, 272)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 12
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Text = "*&Transmitir"
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
        '
        'grdOficinas
        '
        Me.grdOficinas._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdOficinas, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdOficinas, False)
        Me.grdOficinas.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdOficinas.Clip = ""
        Me.grdOficinas.Col = CType(1, Short)
        Me.grdOficinas.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdOficinas.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdOficinas.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdOficinas, "Default")
        Me.grdOficinas.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdOficinas, True)
        Me.grdOficinas.FixedCols = CType(1, Short)
        Me.grdOficinas.FixedRows = CType(1, Short)
        Me.grdOficinas.ForeColor = System.Drawing.Color.Black
        Me.grdOficinas.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdOficinas.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdOficinas.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdOficinas.HighLight = True
        Me.grdOficinas.Location = New System.Drawing.Point(4, 16)
        Me.grdOficinas.Name = "grdOficinas"
        Me.grdOficinas.Picture = Nothing
        Me.grdOficinas.Row = CType(1, Short)
        Me.grdOficinas.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdOficinas.Size = New System.Drawing.Size(547, 103)
        Me.grdOficinas.Sort = CType(2, Short)
        Me.grdOficinas.TabIndex = 10
        Me.grdOficinas.TabStop = False
        Me.grdOficinas.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdOficinas, "")
        '
        '_cmdBoton_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_5, False)
        Me._cmdBoton_5.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_5, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_5, True)
        Me._cmdBoton_5.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_5, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_5, Nothing)
        Me._cmdBoton_5.Enabled = False
        Me._cmdBoton_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_5.Location = New System.Drawing.Point(689, 221)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_5, System.Drawing.Color.Silver)
        Me._cmdBoton_5.Name = "_cmdBoton_5"
        Me._cmdBoton_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_5.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_5, 1)
        Me._cmdBoton_5.TabIndex = 27
        Me._cmdBoton_5.TabStop = False
        Me._cmdBoton_5.Text = "*&Actualizar"
        Me._cmdBoton_5.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_5.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_5, "")
        '
        'frmBloqueo
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.frmBloqueo, False)
        Me.COBISViewResizer.SetAutoResize(Me.frmBloqueo, False)
        Me.frmBloqueo.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.frmBloqueo.Controls.Add(Me.cmbProducto)
        Me.frmBloqueo.Controls.Add(Me._txtCampo_7)
        Me.frmBloqueo.Controls.Add(Me._txtCampo_6)
        Me.frmBloqueo.Controls.Add(Me._txtCampo_5)
        Me.frmBloqueo.Controls.Add(Me._txtCampo_4)
        Me.frmBloqueo.Controls.Add(Me._txtCampo_3)
        Me.frmBloqueo.Controls.Add(Me._txtCampo_1)
        Me.frmBloqueo.Controls.Add(Me._mskValor_0)
        Me.frmBloqueo.Controls.Add(Me._txtCampo_2)
        Me.frmBloqueo.Controls.Add(Me._mskValor_1)
        Me.frmBloqueo.Controls.Add(Me._lblEtiqueta_9)
        Me.frmBloqueo.Controls.Add(Me._lblEtiqueta_8)
        Me.frmBloqueo.Controls.Add(Me._lblEtiqueta_7)
        Me.frmBloqueo.Controls.Add(Me._lblEtiqueta_1)
        Me.frmBloqueo.Controls.Add(Me._lblDescripcion_0)
        Me.frmBloqueo.Controls.Add(Me._lblEtiqueta_4)
        Me.frmBloqueo.Controls.Add(Me._lblEtiqueta_6)
        Me.frmBloqueo.Controls.Add(Me._lblEtiqueta_5)
        Me.frmBloqueo.Controls.Add(Me._lblEtiqueta_0)
        Me.frmBloqueo.Controls.Add(Me._lblEtiqueta_3)
        Me.frmBloqueo.Controls.Add(Me._lblEtiqueta_2)
        Me.COBISStyleProvider.SetControlStyle(Me.frmBloqueo, "Default")
        Me.frmBloqueo.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.frmBloqueo.ForeColor = System.Drawing.Color.Navy
        Me.frmBloqueo.Location = New System.Drawing.Point(10, 10)
        Me.frmBloqueo.Name = "frmBloqueo"
        Me.COBISResourceProvider.SetResourceID(Me.frmBloqueo, "500559")
        Me.frmBloqueo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.frmBloqueo.Size = New System.Drawing.Size(557, 230)
        Me.frmBloqueo.TabIndex = 19
        Me.frmBloqueo.Text = "*Datos de las Líneas "
        Me.frmBloqueo.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.frmBloqueo, "")
        '
        'cmbProducto
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmbProducto, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmbProducto, False)
        Me.cmbProducto.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.cmbProducto, "Default")
        Me.cmbProducto.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbProducto.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbProducto.Location = New System.Drawing.Point(74, 41)
        Me.cmbProducto.Name = "cmbProducto"
        Me.cmbProducto.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbProducto.Size = New System.Drawing.Size(145, 22)
        Me.cmbProducto.TabIndex = 2
        Me.cmbProducto.Text = "CTA. AHORROS"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmbProducto, "")
        '
        '_txtCampo_6
        '
        Me._txtCampo_6.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_6, False)
        Me._txtCampo_6.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_6, "Default")
        Me._txtCampo_6.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_6.Location = New System.Drawing.Point(74, 182)
        Me._txtCampo_6.MaxLength = 79
        Me._txtCampo_6.Name = "_txtCampo_6"
        Me._txtCampo_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_6.Size = New System.Drawing.Size(480, 20)
        Me._txtCampo_6.TabIndex = 8
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_6, "")
        '
        '_txtCampo_5
        '
        Me._txtCampo_5.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_5, False)
        Me._txtCampo_5.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_5, "Default")
        Me._txtCampo_5.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_5.Location = New System.Drawing.Point(74, 66)
        Me._txtCampo_5.MaxLength = 5
        Me._txtCampo_5.Name = "_txtCampo_5"
        Me._txtCampo_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_5.Size = New System.Drawing.Size(49, 20)
        Me._txtCampo_5.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_5, "")
        '
        '_txtCampo_4
        '
        Me._txtCampo_4.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_4, False)
        Me._txtCampo_4.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_4, "Default")
        Me._txtCampo_4.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_4.Location = New System.Drawing.Point(74, 159)
        Me._txtCampo_4.MaxLength = 33
        Me._txtCampo_4.Name = "_txtCampo_4"
        Me._txtCampo_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_4.Size = New System.Drawing.Size(480, 20)
        Me._txtCampo_4.TabIndex = 7
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_4, "")
        '
        '_txtCampo_3
        '
        Me._txtCampo_3.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_3, False)
        Me._txtCampo_3.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_3, "Default")
        Me._txtCampo_3.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_3.Location = New System.Drawing.Point(74, 135)
        Me._txtCampo_3.MaxLength = 33
        Me._txtCampo_3.Name = "_txtCampo_3"
        Me._txtCampo_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_3.Size = New System.Drawing.Size(480, 20)
        Me._txtCampo_3.TabIndex = 6
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_3, "")
        '
        '_txtCampo_1
        '
        Me._txtCampo_1.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_1, False)
        Me._txtCampo_1.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_1, "Default")
        Me._txtCampo_1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_1.Location = New System.Drawing.Point(74, 89)
        Me._txtCampo_1.MaxLength = 33
        Me._txtCampo_1.Name = "_txtCampo_1"
        Me._txtCampo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_1.Size = New System.Drawing.Size(480, 20)
        Me._txtCampo_1.TabIndex = 4
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_1, "")
        '
        '_mskValor_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskValor_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskValor_0, False)
        Me.COBISStyleProvider.SetControlStyle(Me._mskValor_0, "Default")
        Me._mskValor_0.Length = CType(64, Short)
        Me._mskValor_0.Location = New System.Drawing.Point(120, 18)
        Me._mskValor_0.MaxReal = 3.402823E+38!
        Me._mskValor_0.MinReal = -3.402823E+38!
        Me._mskValor_0.Name = "_mskValor_0"
        Me._mskValor_0.Size = New System.Drawing.Size(97, 20)
        Me._mskValor_0.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskValor_0, "")
        '
        '_txtCampo_2
        '
        Me._txtCampo_2.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_2, False)
        Me._txtCampo_2.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_2, "Default")
        Me._txtCampo_2.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_2.Location = New System.Drawing.Point(74, 112)
        Me._txtCampo_2.MaxLength = 33
        Me._txtCampo_2.Name = "_txtCampo_2"
        Me._txtCampo_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_2.Size = New System.Drawing.Size(479, 20)
        Me._txtCampo_2.TabIndex = 5
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_2, "")
        '
        '_mskValor_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskValor_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskValor_1, False)
        Me.COBISStyleProvider.SetControlStyle(Me._mskValor_1, "Default")
        Me._mskValor_1.Length = CType(64, Short)
        Me._mskValor_1.Location = New System.Drawing.Point(348, 18)
        Me._mskValor_1.MaxReal = 3.402823E+38!
        Me._mskValor_1.MinReal = -3.402823E+38!
        Me._mskValor_1.Name = "_mskValor_1"
        Me._mskValor_1.Size = New System.Drawing.Size(97, 20)
        Me._mskValor_1.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskValor_1, "")
        '
        '_lblEtiqueta_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_9, False)
        Me._lblEtiqueta_9.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_9, "Default")
        Me._lblEtiqueta_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_9.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_9.Location = New System.Drawing.Point(5, 41)
        Me._lblEtiqueta_9.Name = "_lblEtiqueta_9"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_9, "5048")
        Me._lblEtiqueta_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_9.Size = New System.Drawing.Size(63, 20)
        Me._lblEtiqueta_9.TabIndex = 30
        Me._lblEtiqueta_9.Text = "*Producto:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_9, "")
        '
        '_lblEtiqueta_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_8, False)
        Me._lblEtiqueta_8.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_8, "Default")
        Me._lblEtiqueta_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_8.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_8.Location = New System.Drawing.Point(5, 205)
        Me._lblEtiqueta_8.Name = "_lblEtiqueta_8"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_8, "500560")
        Me._lblEtiqueta_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_8.Size = New System.Drawing.Size(63, 20)
        Me._lblEtiqueta_8.TabIndex = 29
        Me._lblEtiqueta_8.Text = "*Línea 6:"
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
        Me._lblEtiqueta_7.Location = New System.Drawing.Point(5, 182)
        Me._lblEtiqueta_7.Name = "_lblEtiqueta_7"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_7, "500561")
        Me._lblEtiqueta_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_7.Size = New System.Drawing.Size(63, 20)
        Me._lblEtiqueta_7.TabIndex = 28
        Me._lblEtiqueta_7.Text = "*Línea 5:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_7, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(228, 20)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "500562")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(119, 20)
        Me._lblEtiqueta_1.TabIndex = 26
        Me._lblEtiqueta_1.Text = "*Fecha Fin.Vigencia:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_lblDescripcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_0, False)
        Me._lblDescripcion_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_0, "Default")
        Me._lblDescripcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_0.Location = New System.Drawing.Point(123, 66)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(303, 19)
        Me._lblDescripcion_0.TabIndex = 15
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        '_lblEtiqueta_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_4, False)
        Me._lblEtiqueta_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_4, "Default")
        Me._lblEtiqueta_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_4.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_4.Location = New System.Drawing.Point(5, 66)
        Me._lblEtiqueta_4.Name = "_lblEtiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_4, "502612")
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(68, 20)
        Me._lblEtiqueta_4.TabIndex = 22
        Me._lblEtiqueta_4.Text = "*Producto B:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_4, "")
        '
        '_lblEtiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_6, False)
        Me._lblEtiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_6, "Default")
        Me._lblEtiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(5, 135)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "500563")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(49, 20)
        Me._lblEtiqueta_6.TabIndex = 17
        Me._lblEtiqueta_6.Text = "*Línea 3:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
        '
        '_lblEtiqueta_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_5, False)
        Me._lblEtiqueta_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_5, "Default")
        Me._lblEtiqueta_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_5.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_5.Location = New System.Drawing.Point(5, 112)
        Me._lblEtiqueta_5.Name = "_lblEtiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_5, "5167")
        Me._lblEtiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_5.Size = New System.Drawing.Size(49, 20)
        Me._lblEtiqueta_5.TabIndex = 18
        Me._lblEtiqueta_5.Text = "*Línea 2:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_5, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(5, 158)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "500564")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(49, 20)
        Me._lblEtiqueta_0.TabIndex = 21
        Me._lblEtiqueta_0.Text = "*Línea 4:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        '_lblEtiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(5, 89)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "5166")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(49, 20)
        Me._lblEtiqueta_3.TabIndex = 20
        Me._lblEtiqueta_3.Text = "*Línea 1:"
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
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(5, 20)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "500565")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(116, 20)
        Me._lblEtiqueta_2.TabIndex = 16
        Me._lblEtiqueta_2.Text = "*Fecha Ini.Vigencia:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me.frmBloqueo)
        Me.PFormas.Controls.Add(Me._picVisto_0)
        Me.PFormas.Controls.Add(Me._picVisto_1)
        Me.PFormas.Controls.Add(Me._cmdBoton_4)
        Me.PFormas.Controls.Add(Me._cmdBoton_3)
        Me.PFormas.Controls.Add(Me._cmdBoton_5)
        Me.PFormas.Controls.Add(Me._cmdBoton_2)
        Me.PFormas.Controls.Add(Me._cmdBoton_1)
        Me.PFormas.Controls.Add(Me._cmdBoton_0)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(575, 508)
        Me.PFormas.TabIndex = 32
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
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
        Me.COBISStyleProvider.SetEnableStyle(Me.grdPropietarios, True)
        Me.grdPropietarios.FixedCols = CType(1, Short)
        Me.grdPropietarios.FixedRows = CType(1, Short)
        Me.grdPropietarios.ForeColor = System.Drawing.Color.Black
        Me.grdPropietarios.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdPropietarios.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdPropietarios.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdPropietarios.HighLight = True
        Me.grdPropietarios.Location = New System.Drawing.Point(4, 135)
        Me.grdPropietarios.Name = "grdPropietarios"
        Me.grdPropietarios.Picture = Nothing
        Me.grdPropietarios.Row = CType(1, Short)
        Me.grdPropietarios.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdPropietarios.Size = New System.Drawing.Size(547, 103)
        Me.grdPropietarios.Sort = CType(2, Short)
        Me.grdPropietarios.TabIndex = 11
        Me.grdPropietarios.TabStop = False
        Me.grdPropietarios.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdPropietarios, "")
        '
        'TSBBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBBotones, "Default")
        Me.TSBBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBEliminar, Me.TSBActualizar, Me.TSBTransmitir, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBBotones.Name = "TSBBotones"
        Me.TSBBotones.Size = New System.Drawing.Size(593, 25)
        Me.TSBBotones.TabIndex = 33
        Me.TSBBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBBotones, "")
        '
        'TSBBuscar
        '
        Me.TSBBuscar.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.Size = New System.Drawing.Size(65, 22)
        Me.TSBBuscar.Text = "*&Buscar"
        '
        'TSBEliminar
        '
        Me.TSBEliminar.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBEliminar.Image = CType(resources.GetObject("TSBEliminar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEliminar, "2006")
        Me.TSBEliminar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEliminar.Name = "TSBEliminar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEliminar, "2050")
        Me.TSBEliminar.Size = New System.Drawing.Size(69, 22)
        Me.TSBEliminar.Text = "*&Eliminar"
        '
        'TSBActualizar
        '
        Me.TSBActualizar.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBActualizar.Image = CType(resources.GetObject("TSBActualizar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBActualizar, "2010")
        Me.TSBActualizar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBActualizar.Name = "TSBActualizar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBActualizar, "2031")
        Me.TSBActualizar.Size = New System.Drawing.Size(80, 22)
        Me.TSBActualizar.Text = "*&Actualizar"
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBTransmitir.Image = CType(resources.GetObject("TSBTransmitir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBTransmitir, "2004")
        Me.TSBTransmitir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBTransmitir.Name = "TSBTransmitir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.Size = New System.Drawing.Size(80, 22)
        Me.TSBTransmitir.Text = "*&Transmitir"
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBLimpiar.Image = CType(resources.GetObject("TSBLimpiar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBLimpiar.Name = "TSBLimpiar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.Size = New System.Drawing.Size(66, 22)
        Me.TSBLimpiar.Text = "*&Limpiar"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "2008")
        Me.TSBSalir.Size = New System.Drawing.Size(53, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColor = System.Drawing.Color.Transparent
        Me.GroupBox1.Controls.Add(Me.grdOficinas)
        Me.GroupBox1.Controls.Add(Me.grdPropietarios)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.Location = New System.Drawing.Point(10, 246)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(557, 247)
        Me.GroupBox1.TabIndex = 28
        Me.GroupBox1.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'FTran099Class
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBBotones)
        Me.Controls.Add(Me.PFormas)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Arial", 6.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(22, 155)
        Me.Name = "FTran099Class"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(593, 554)
        Me.Text = "Definición de Mensajes para Estados de Cuenta por Oficina"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me._picVisto_0, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me._picVisto_1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.grdOficinas, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.frmBloqueo, System.ComponentModel.ISupportInitialize).EndInit()
        Me.frmBloqueo.ResumeLayout(False)
        Me.frmBloqueo.PerformLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        CType(Me.grdPropietarios, System.ComponentModel.ISupportInitialize).EndInit()
        Me.TSBBotones.ResumeLayout(False)
        Me.TSBBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializetxtCampo()
        Me.txtCampo(7) = _txtCampo_7
        Me.txtCampo(6) = _txtCampo_6
        Me.txtCampo(5) = _txtCampo_5
        Me.txtCampo(4) = _txtCampo_4
        Me.txtCampo(3) = _txtCampo_3
        Me.txtCampo(1) = _txtCampo_1
        Me.txtCampo(2) = _txtCampo_2
    End Sub
    Sub InitializepicVisto()
        Me.picVisto(0) = _picVisto_0
        Me.picVisto(1) = _picVisto_1
    End Sub
    Sub InitializemskValor()
        Me.mskValor(0) = _mskValor_0
        Me.mskValor(1) = _mskValor_1
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(9) = _lblEtiqueta_9
        Me.lblEtiqueta(8) = _lblEtiqueta_8
        Me.lblEtiqueta(7) = _lblEtiqueta_7
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(6) = _lblEtiqueta_6
        Me.lblEtiqueta(5) = _lblEtiqueta_5
        Me.lblEtiqueta(0) = _lblEtiqueta_0
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(2) = _lblEtiqueta_2
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(0) = _lblDescripcion_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(5) = _cmdBoton_5
    End Sub
    'Sub InitializeLine1()
    '    Me.Line1(2) = _Line1_2
    '    Me.Line1(0) = _Line1_0
    '    Me.Line1(1) = _Line1_1
    'End Sub

    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEliminar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBActualizar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Public WithEvents grdPropietarios As COBISCorp.Framework.UI.Components.COBISGrid
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
#End Region
End Class


