Imports COBISCorp.tCOBIS.TADMIN.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Ftran2797Class
#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        isInitializingComponent = True
        InitializeComponent()
        isInitializingComponent = False
        InitializelblEtiqueta()
        InitializecmdBoton()
        Initializecmbide()
        InitializecmbTipo()
        InitializeOption1()
        InitializeMhRealValor()
        InitializeMaskpers_ced_nit()
        ' InitializeLine1()
        InitializeLabel7()
        InitializeLabel6()
        InitializeFrame2()
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
    Private WithEvents _MhRealValor_1 As COBISCorp.Framework.UI.Components.CobisRealInput
    Private WithEvents _MhRealValor_0 As COBISCorp.Framework.UI.Components.CobisRealInput
    Private WithEvents _Option1_3 As System.Windows.Forms.RadioButton
    Public WithEvents ChkFiltros As System.Windows.Forms.CheckBox
    Private WithEvents _cmbTipo_1 As System.Windows.Forms.ComboBox
    Private WithEvents _cmbTipo_2 As System.Windows.Forms.ComboBox
    Private WithEvents _Option1_2 As System.Windows.Forms.RadioButton
    Private WithEvents _Option1_1 As System.Windows.Forms.RadioButton
    Private WithEvents _Option1_0 As System.Windows.Forms.RadioButton
    Public WithEvents txtNomCta As System.Windows.Forms.TextBox
    Private WithEvents _cmbTipo_0 As System.Windows.Forms.ComboBox
    Public WithEvents Ide As System.Windows.Forms.TextBox
    Public WithEvents mskCuenta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _lblEtiqueta_14 As System.Windows.Forms.Label
    Private WithEvents _Label6_2 As System.Windows.Forms.Label
    Private WithEvents _Label7_2 As System.Windows.Forms.Label
    Private WithEvents _Frame2_2 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _cmbide_1 As System.Windows.Forms.ComboBox
    Private WithEvents _Maskpers_ced_nit_1 As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _Label6_1 As System.Windows.Forms.Label
    Private WithEvents _Label7_1 As System.Windows.Forms.Label
    Private WithEvents _Frame2_1 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _cmbide_0 As System.Windows.Forms.ComboBox
    Private WithEvents _Maskpers_ced_nit_0 As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _Label7_0 As System.Windows.Forms.Label
    Private WithEvents _Label6_0 As System.Windows.Forms.Label
    Private WithEvents _Frame2_0 As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents txtOficRecep As System.Windows.Forms.TextBox
    Public WithEvents mskFechaIni As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Public WithEvents mskFechaFin As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Public WithEvents grdProductos As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmbide_3 As System.Windows.Forms.ComboBox
    Private WithEvents _Maskpers_ced_nit_3 As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _Label7_3 As System.Windows.Forms.Label
    Private WithEvents _Label6_3 As System.Windows.Forms.Label
    Private WithEvents _Frame2_3 As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents lblOfiRecep As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Public WithEvents Frame1 As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents grdChequeras As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Public Frame2(3) As Infragistics.Win.Misc.UltraGroupBox
    Public Label6(3) As System.Windows.Forms.Label
    Public Label7(3) As System.Windows.Forms.Label
    Public Line1(1) As System.Windows.Forms.Label
    Public Maskpers_ced_nit(3) As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Public MhRealValor(1) As COBISCorp.Framework.UI.Components.CobisRealInput
    Public Option1(3) As System.Windows.Forms.RadioButton
    Public cmbTipo(2) As System.Windows.Forms.ComboBox
    Public cmbide(3) As System.Windows.Forms.ComboBox
    Public cmdBoton(4) As System.Windows.Forms.Button
    Public lblEtiqueta(14) As System.Windows.Forms.Label
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(Ftran2797Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.Frame1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TableLayoutPanel1 = New System.Windows.Forms.TableLayoutPanel()
        Me._Frame2_0 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._cmbide_0 = New System.Windows.Forms.ComboBox()
        Me._Maskpers_ced_nit_0 = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._Label7_0 = New System.Windows.Forms.Label()
        Me._Label6_0 = New System.Windows.Forms.Label()
        Me._Option1_0 = New System.Windows.Forms.RadioButton()
        Me._Option1_1 = New System.Windows.Forms.RadioButton()
        Me._Option1_3 = New System.Windows.Forms.RadioButton()
        Me._Frame2_1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._cmbide_1 = New System.Windows.Forms.ComboBox()
        Me._Maskpers_ced_nit_1 = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._Label6_1 = New System.Windows.Forms.Label()
        Me._Label7_1 = New System.Windows.Forms.Label()
        Me._Frame2_3 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._cmbide_3 = New System.Windows.Forms.ComboBox()
        Me._Maskpers_ced_nit_3 = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._Label7_3 = New System.Windows.Forms.Label()
        Me._Label6_3 = New System.Windows.Forms.Label()
        Me._Option1_2 = New System.Windows.Forms.RadioButton()
        Me._Frame2_2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.txtNomCta = New System.Windows.Forms.TextBox()
        Me._cmbTipo_0 = New System.Windows.Forms.ComboBox()
        Me.Ide = New System.Windows.Forms.TextBox()
        Me.mskCuenta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._lblEtiqueta_14 = New System.Windows.Forms.Label()
        Me._Label6_2 = New System.Windows.Forms.Label()
        Me._Label7_2 = New System.Windows.Forms.Label()
        Me._MhRealValor_1 = New COBISCorp.Framework.UI.Components.CobisRealInput()
        Me._MhRealValor_0 = New COBISCorp.Framework.UI.Components.CobisRealInput()
        Me.ChkFiltros = New System.Windows.Forms.CheckBox()
        Me.txtOficRecep = New System.Windows.Forms.TextBox()
        Me.mskFechaIni = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.mskFechaFin = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.grdProductos = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.lblOfiRecep = New System.Windows.Forms.Label()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._cmbTipo_1 = New System.Windows.Forms.ComboBox()
        Me._cmbTipo_2 = New System.Windows.Forms.ComboBox()
        Me.grdChequeras = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSiguientes = New System.Windows.Forms.ToolStripButton()
        Me.TSBExcel = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.Pforma = New Infragistics.Win.Misc.UltraGroupBox()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.Frame1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame1.SuspendLayout()
        Me.TableLayoutPanel1.SuspendLayout()
        CType(Me._Frame2_0, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._Frame2_0.SuspendLayout()
        CType(Me._Frame2_1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._Frame2_1.SuspendLayout()
        CType(Me._Frame2_3, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._Frame2_3.SuspendLayout()
        CType(Me._Frame2_2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._Frame2_2.SuspendLayout()
        CType(Me.grdProductos, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.grdChequeras, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
        Me.TSBBotones.SuspendLayout()
        CType(Me.Pforma, System.ComponentModel.ISupportInitialize).BeginInit()
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
        'Frame1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame1, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame1, False)
        Me.Frame1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Frame1.Controls.Add(Me.TableLayoutPanel1)
        Me.Frame1.Controls.Add(Me._MhRealValor_1)
        Me.Frame1.Controls.Add(Me._MhRealValor_0)
        Me.Frame1.Controls.Add(Me.ChkFiltros)
        Me.Frame1.Controls.Add(Me.txtOficRecep)
        Me.Frame1.Controls.Add(Me.mskFechaIni)
        Me.Frame1.Controls.Add(Me.mskFechaFin)
        Me.Frame1.Controls.Add(Me.lblOfiRecep)
        Me.Frame1.Controls.Add(Me._lblEtiqueta_4)
        Me.Frame1.Controls.Add(Me._lblEtiqueta_3)
        Me.Frame1.Controls.Add(Me._lblEtiqueta_2)
        Me.Frame1.Controls.Add(Me._lblEtiqueta_1)
        Me.Frame1.Controls.Add(Me._lblEtiqueta_0)
        Me.COBISStyleProvider.SetControlStyle(Me.Frame1, "Default")
        Me.Frame1.ForeColor = System.Drawing.Color.Navy
        Me.Frame1.Location = New System.Drawing.Point(10, 10)
        Me.Frame1.Name = "Frame1"
        Me.Frame1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame1.Size = New System.Drawing.Size(546, 422)
        Me.Frame1.TabIndex = 25
        Me.Frame1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame1, "")
        '
        'TableLayoutPanel1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TableLayoutPanel1, False)
        Me.COBISViewResizer.SetAutoResize(Me.TableLayoutPanel1, False)
        Me.TableLayoutPanel1.BackColor = System.Drawing.Color.Transparent
        Me.TableLayoutPanel1.ColumnCount = 1
        Me.TableLayoutPanel1.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100.0!))
        Me.TableLayoutPanel1.Controls.Add(Me._Frame2_0, 0, 1)
        Me.TableLayoutPanel1.Controls.Add(Me._Option1_0, 0, 0)
        Me.TableLayoutPanel1.Controls.Add(Me._Option1_1, 0, 2)
        Me.TableLayoutPanel1.Controls.Add(Me._Option1_3, 0, 4)
        Me.TableLayoutPanel1.Controls.Add(Me._Frame2_1, 0, 3)
        Me.TableLayoutPanel1.Controls.Add(Me._Frame2_3, 0, 5)
        Me.TableLayoutPanel1.Controls.Add(Me._Option1_2, 0, 6)
        Me.TableLayoutPanel1.Controls.Add(Me._Frame2_2, 0, 7)
        Me.COBISStyleProvider.SetControlStyle(Me.TableLayoutPanel1, "Default")
        Me.TableLayoutPanel1.Location = New System.Drawing.Point(13, 113)
        Me.TableLayoutPanel1.Name = "TableLayoutPanel1"
        Me.TableLayoutPanel1.RowCount = 8
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle())
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 22.22222!))
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle())
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 22.22222!))
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle())
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 22.22222!))
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle())
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 33.33333!))
        Me.TableLayoutPanel1.Size = New System.Drawing.Size(528, 299)
        Me.TableLayoutPanel1.TabIndex = 47
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TableLayoutPanel1, "")
        '
        '_Frame2_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Frame2_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._Frame2_0, False)
        Me._Frame2_0.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._Frame2_0.Controls.Add(Me._cmbide_0)
        Me._Frame2_0.Controls.Add(Me._Maskpers_ced_nit_0)
        Me._Frame2_0.Controls.Add(Me._Label7_0)
        Me._Frame2_0.Controls.Add(Me._Label6_0)
        Me.COBISStyleProvider.SetControlStyle(Me._Frame2_0, "Default")
        Me._Frame2_0.Dock = System.Windows.Forms.DockStyle.Fill
        Me._Frame2_0.ForeColor = System.Drawing.Color.Navy
        Me._Frame2_0.Location = New System.Drawing.Point(3, 33)
        Me._Frame2_0.Name = "_Frame2_0"
        Me._Frame2_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame2_0.Size = New System.Drawing.Size(522, 37)
        Me._Frame2_0.TabIndex = 28
        Me._Frame2_0.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Frame2_0, "")
        '
        '_cmbide_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmbide_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmbide_0, False)
        Me._cmbide_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._cmbide_0, "Default")
        Me._cmbide_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._cmbide_0.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._cmbide_0.Enabled = False
        Me._cmbide_0.ForeColor = System.Drawing.SystemColors.WindowText
        Me._cmbide_0.Location = New System.Drawing.Point(104, 7)
        Me._cmbide_0.Name = "_cmbide_0"
        Me._cmbide_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmbide_0.Size = New System.Drawing.Size(57, 21)
        Me._cmbide_0.TabIndex = 7
        Me._cmbide_0.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmbide_0, "")
        '
        '_Maskpers_ced_nit_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Maskpers_ced_nit_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._Maskpers_ced_nit_0, False)
        Me.COBISStyleProvider.SetControlStyle(Me._Maskpers_ced_nit_0, "Default")
        Me._Maskpers_ced_nit_0.Enabled = False
        Me._Maskpers_ced_nit_0.Length = CType(12, Short)
        Me._Maskpers_ced_nit_0.Location = New System.Drawing.Point(378, 7)
        Me._Maskpers_ced_nit_0.MaxReal = 3.402823E+38!
        Me._Maskpers_ced_nit_0.MinReal = -3.402823E+38!
        Me._Maskpers_ced_nit_0.Name = "_Maskpers_ced_nit_0"
        Me._Maskpers_ced_nit_0.Size = New System.Drawing.Size(122, 20)
        Me._Maskpers_ced_nit_0.TabIndex = 8
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Maskpers_ced_nit_0, "")
        '
        '_Label7_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Label7_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._Label7_0, False)
        Me._Label7_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._Label7_0, "Default")
        Me._Label7_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label7_0.Enabled = False
        Me._Label7_0.ForeColor = System.Drawing.Color.Navy
        Me._Label7_0.Location = New System.Drawing.Point(41, 7)
        Me._Label7_0.Name = "_Label7_0"
        Me.COBISResourceProvider.SetResourceID(Me._Label7_0, "5084")
        Me._Label7_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label7_0.Size = New System.Drawing.Size(32, 20)
        Me._Label7_0.TabIndex = 34
        Me._Label7_0.Text = "*Tipo"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Label7_0, "")
        '
        '_Label6_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Label6_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._Label6_0, False)
        Me._Label6_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._Label6_0, "Default")
        Me._Label6_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label6_0.Enabled = False
        Me._Label6_0.ForeColor = System.Drawing.Color.Navy
        Me._Label6_0.Location = New System.Drawing.Point(294, 7)
        Me._Label6_0.Name = "_Label6_0"
        Me.COBISResourceProvider.SetResourceID(Me._Label6_0, "501112")
        Me._Label6_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label6_0.Size = New System.Drawing.Size(78, 20)
        Me._Label6_0.TabIndex = 33
        Me._Label6_0.Text = "*Identificación"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Label6_0, "")
        '
        '_Option1_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Option1_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._Option1_0, False)
        Me._Option1_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._Option1_0, "Default")
        Me._Option1_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Option1_0.ForeColor = System.Drawing.Color.Red
        Me._Option1_0.Location = New System.Drawing.Point(6, 6)
        Me._Option1_0.Margin = New System.Windows.Forms.Padding(6)
        Me._Option1_0.Name = "_Option1_0"
        Me.COBISResourceProvider.SetResourceID(Me._Option1_0, "508686")
        Me._Option1_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Option1_0.Size = New System.Drawing.Size(280, 18)
        Me._Option1_0.TabIndex = 6
        Me._Option1_0.TabStop = True
        Me._Option1_0.Text = "Persona que realizó la transacción"
        Me._Option1_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Option1_0, "")
        '
        '_Option1_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Option1_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._Option1_1, False)
        Me._Option1_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._Option1_1, "Default")
        Me._Option1_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Option1_1.Dock = System.Windows.Forms.DockStyle.Fill
        Me._Option1_1.ForeColor = System.Drawing.Color.Red
        Me._Option1_1.Location = New System.Drawing.Point(3, 76)
        Me._Option1_1.Name = "_Option1_1"
        Me.COBISResourceProvider.SetResourceID(Me._Option1_1, "508684")
        Me._Option1_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Option1_1.Size = New System.Drawing.Size(522, 18)
        Me._Option1_1.TabIndex = 7
        Me._Option1_1.TabStop = True
        Me._Option1_1.Text = "Persona en nombre de quien se realiza la transacción"
        Me._Option1_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Option1_1, "")
        '
        '_Option1_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Option1_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._Option1_3, False)
        Me._Option1_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._Option1_3, "Default")
        Me._Option1_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._Option1_3.Dock = System.Windows.Forms.DockStyle.Fill
        Me._Option1_3.ForeColor = System.Drawing.Color.Red
        Me._Option1_3.Location = New System.Drawing.Point(3, 143)
        Me._Option1_3.Name = "_Option1_3"
        Me._Option1_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Option1_3.Size = New System.Drawing.Size(522, 18)
        Me._Option1_3.TabIndex = 8
        Me._Option1_3.TabStop = True
        Me._Option1_3.Text = "Beneficiario"
        Me._Option1_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Option1_3, "")
        '
        '_Frame2_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Frame2_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._Frame2_1, False)
        Me._Frame2_1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._Frame2_1.Controls.Add(Me._cmbide_1)
        Me._Frame2_1.Controls.Add(Me._Maskpers_ced_nit_1)
        Me._Frame2_1.Controls.Add(Me._Label6_1)
        Me._Frame2_1.Controls.Add(Me._Label7_1)
        Me.COBISStyleProvider.SetControlStyle(Me._Frame2_1, "Default")
        Me._Frame2_1.Dock = System.Windows.Forms.DockStyle.Fill
        Me._Frame2_1.ForeColor = System.Drawing.Color.Navy
        Me._Frame2_1.Location = New System.Drawing.Point(3, 100)
        Me._Frame2_1.Name = "_Frame2_1"
        Me._Frame2_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame2_1.Size = New System.Drawing.Size(522, 37)
        Me._Frame2_1.TabIndex = 35
        Me._Frame2_1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Frame2_1, "")
        '
        '_cmbide_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmbide_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmbide_1, False)
        Me._cmbide_1.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._cmbide_1, "Default")
        Me._cmbide_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._cmbide_1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._cmbide_1.Enabled = False
        Me._cmbide_1.ForeColor = System.Drawing.SystemColors.WindowText
        Me._cmbide_1.Location = New System.Drawing.Point(104, 7)
        Me._cmbide_1.Name = "_cmbide_1"
        Me._cmbide_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmbide_1.Size = New System.Drawing.Size(57, 21)
        Me._cmbide_1.TabIndex = 10
        Me._cmbide_1.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmbide_1, "")
        '
        '_Maskpers_ced_nit_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Maskpers_ced_nit_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._Maskpers_ced_nit_1, False)
        Me.COBISStyleProvider.SetControlStyle(Me._Maskpers_ced_nit_1, "Default")
        Me._Maskpers_ced_nit_1.Enabled = False
        Me._Maskpers_ced_nit_1.Length = CType(10, Short)
        Me._Maskpers_ced_nit_1.Location = New System.Drawing.Point(378, 7)
        Me._Maskpers_ced_nit_1.MaxReal = 3.402823E+38!
        Me._Maskpers_ced_nit_1.MinReal = -3.402823E+38!
        Me._Maskpers_ced_nit_1.Name = "_Maskpers_ced_nit_1"
        Me._Maskpers_ced_nit_1.Size = New System.Drawing.Size(122, 20)
        Me._Maskpers_ced_nit_1.TabIndex = 11
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Maskpers_ced_nit_1, "")
        '
        '_Label6_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Label6_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._Label6_1, False)
        Me._Label6_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._Label6_1, "Default")
        Me._Label6_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label6_1.Enabled = False
        Me._Label6_1.ForeColor = System.Drawing.Color.Navy
        Me._Label6_1.Location = New System.Drawing.Point(294, 7)
        Me._Label6_1.Name = "_Label6_1"
        Me.COBISResourceProvider.SetResourceID(Me._Label6_1, "501112")
        Me._Label6_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label6_1.Size = New System.Drawing.Size(78, 20)
        Me._Label6_1.TabIndex = 37
        Me._Label6_1.Text = "*Identificación"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Label6_1, "")
        '
        '_Label7_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Label7_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._Label7_1, False)
        Me._Label7_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._Label7_1, "Default")
        Me._Label7_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label7_1.Enabled = False
        Me._Label7_1.ForeColor = System.Drawing.Color.Navy
        Me._Label7_1.Location = New System.Drawing.Point(41, 7)
        Me._Label7_1.Name = "_Label7_1"
        Me.COBISResourceProvider.SetResourceID(Me._Label7_1, "5084")
        Me._Label7_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label7_1.Size = New System.Drawing.Size(32, 20)
        Me._Label7_1.TabIndex = 36
        Me._Label7_1.Text = "*Tipo"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Label7_1, "")
        '
        '_Frame2_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Frame2_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._Frame2_3, False)
        Me._Frame2_3.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._Frame2_3.Controls.Add(Me._cmbide_3)
        Me._Frame2_3.Controls.Add(Me._Maskpers_ced_nit_3)
        Me._Frame2_3.Controls.Add(Me._Label7_3)
        Me._Frame2_3.Controls.Add(Me._Label6_3)
        Me.COBISStyleProvider.SetControlStyle(Me._Frame2_3, "Default")
        Me._Frame2_3.Dock = System.Windows.Forms.DockStyle.Fill
        Me._Frame2_3.ForeColor = System.Drawing.Color.Navy
        Me._Frame2_3.Location = New System.Drawing.Point(3, 167)
        Me._Frame2_3.Name = "_Frame2_3"
        Me._Frame2_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame2_3.Size = New System.Drawing.Size(522, 37)
        Me._Frame2_3.TabIndex = 46
        Me._Frame2_3.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Frame2_3, "")
        '
        '_cmbide_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmbide_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmbide_3, False)
        Me._cmbide_3.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._cmbide_3, "Default")
        Me._cmbide_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._cmbide_3.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._cmbide_3.Enabled = False
        Me._cmbide_3.ForeColor = System.Drawing.SystemColors.WindowText
        Me._cmbide_3.Location = New System.Drawing.Point(104, 7)
        Me._cmbide_3.Name = "_cmbide_3"
        Me._cmbide_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmbide_3.Size = New System.Drawing.Size(57, 21)
        Me._cmbide_3.TabIndex = 13
        Me._cmbide_3.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmbide_3, "")
        '
        '_Maskpers_ced_nit_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Maskpers_ced_nit_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._Maskpers_ced_nit_3, False)
        Me.COBISStyleProvider.SetControlStyle(Me._Maskpers_ced_nit_3, "Default")
        Me._Maskpers_ced_nit_3.Enabled = False
        Me._Maskpers_ced_nit_3.Length = CType(10, Short)
        Me._Maskpers_ced_nit_3.Location = New System.Drawing.Point(378, 7)
        Me._Maskpers_ced_nit_3.MaxReal = 3.402823E+38!
        Me._Maskpers_ced_nit_3.MinReal = -3.402823E+38!
        Me._Maskpers_ced_nit_3.Name = "_Maskpers_ced_nit_3"
        Me._Maskpers_ced_nit_3.Size = New System.Drawing.Size(122, 20)
        Me._Maskpers_ced_nit_3.TabIndex = 15
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Maskpers_ced_nit_3, "")
        '
        '_Label7_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Label7_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._Label7_3, False)
        Me._Label7_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._Label7_3, "Default")
        Me._Label7_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label7_3.Enabled = False
        Me._Label7_3.ForeColor = System.Drawing.Color.Navy
        Me._Label7_3.Location = New System.Drawing.Point(41, 7)
        Me._Label7_3.Name = "_Label7_3"
        Me.COBISResourceProvider.SetResourceID(Me._Label7_3, "5084")
        Me._Label7_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label7_3.Size = New System.Drawing.Size(32, 20)
        Me._Label7_3.TabIndex = 47
        Me._Label7_3.Text = "*Tipo"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Label7_3, "")
        '
        '_Label6_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Label6_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._Label6_3, False)
        Me._Label6_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._Label6_3, "Default")
        Me._Label6_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label6_3.Enabled = False
        Me._Label6_3.ForeColor = System.Drawing.Color.Navy
        Me._Label6_3.Location = New System.Drawing.Point(294, 7)
        Me._Label6_3.Name = "_Label6_3"
        Me.COBISResourceProvider.SetResourceID(Me._Label6_3, "501112")
        Me._Label6_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label6_3.Size = New System.Drawing.Size(78, 20)
        Me._Label6_3.TabIndex = 14
        Me._Label6_3.Text = "*Identificación"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Label6_3, "")
        '
        '_Option1_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Option1_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._Option1_2, False)
        Me._Option1_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._Option1_2, "Default")
        Me._Option1_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Option1_2.Dock = System.Windows.Forms.DockStyle.Fill
        Me._Option1_2.ForeColor = System.Drawing.Color.Red
        Me._Option1_2.Location = New System.Drawing.Point(3, 210)
        Me._Option1_2.Name = "_Option1_2"
        Me._Option1_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Option1_2.Size = New System.Drawing.Size(522, 18)
        Me._Option1_2.TabIndex = 9
        Me._Option1_2.TabStop = True
        Me._Option1_2.Text = "Titular de la cuenta"
        Me._Option1_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Option1_2, "")
        '
        '_Frame2_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Frame2_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._Frame2_2, False)
        Me._Frame2_2.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._Frame2_2.Controls.Add(Me.txtNomCta)
        Me._Frame2_2.Controls.Add(Me._cmbTipo_0)
        Me._Frame2_2.Controls.Add(Me.Ide)
        Me._Frame2_2.Controls.Add(Me.mskCuenta)
        Me._Frame2_2.Controls.Add(Me._lblEtiqueta_14)
        Me._Frame2_2.Controls.Add(Me._Label6_2)
        Me._Frame2_2.Controls.Add(Me._Label7_2)
        Me.COBISStyleProvider.SetControlStyle(Me._Frame2_2, "Default")
        Me._Frame2_2.Dock = System.Windows.Forms.DockStyle.Fill
        Me._Frame2_2.ForeColor = System.Drawing.Color.Navy
        Me._Frame2_2.Location = New System.Drawing.Point(3, 234)
        Me._Frame2_2.Name = "_Frame2_2"
        Me._Frame2_2.Size = New System.Drawing.Size(522, 62)
        Me._Frame2_2.TabIndex = 38
        Me._Frame2_2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Frame2_2, "")
        '
        'txtNomCta
        '
        Me.txtNomCta.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtNomCta, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtNomCta, False)
        Me.txtNomCta.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtNomCta, "Default")
        Me.txtNomCta.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtNomCta.Location = New System.Drawing.Point(171, 35)
        Me.txtNomCta.MaxLength = 40
        Me.txtNomCta.Name = "txtNomCta"
        Me.txtNomCta.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtNomCta.Size = New System.Drawing.Size(329, 20)
        Me.txtNomCta.TabIndex = 48
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtNomCta, "")
        '
        '_cmbTipo_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmbTipo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmbTipo_0, False)
        Me._cmbTipo_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._cmbTipo_0, "Default")
        Me._cmbTipo_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._cmbTipo_0.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._cmbTipo_0.Enabled = False
        Me._cmbTipo_0.ForeColor = System.Drawing.SystemColors.WindowText
        Me._cmbTipo_0.Location = New System.Drawing.Point(104, 9)
        Me._cmbTipo_0.Name = "_cmbTipo_0"
        Me._cmbTipo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmbTipo_0.Size = New System.Drawing.Size(163, 21)
        Me._cmbTipo_0.TabIndex = 17
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmbTipo_0, "")
        '
        'Ide
        '
        Me.Ide.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.Ide, False)
        Me.COBISViewResizer.SetAutoResize(Me.Ide, False)
        Me.Ide.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.Ide, "Default")
        Me.Ide.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.Ide.Enabled = False
        Me.Ide.Location = New System.Drawing.Point(104, 35)
        Me.Ide.MaxLength = 15
        Me.Ide.Name = "Ide"
        Me.Ide.ReadOnly = True
        Me.Ide.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Ide.Size = New System.Drawing.Size(67, 20)
        Me.Ide.TabIndex = 19
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Ide, "")
        '
        'mskCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuenta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuenta, "Default")
        Me.mskCuenta.Enabled = False
        Me.mskCuenta.Length = CType(64, Short)
        Me.mskCuenta.Location = New System.Drawing.Point(378, 9)
        Me.mskCuenta.MaxReal = 3.402823E+38!
        Me.mskCuenta.MinReal = -3.402823E+38!
        Me.mskCuenta.Name = "mskCuenta"
        Me.mskCuenta.Size = New System.Drawing.Size(122, 20)
        Me.mskCuenta.TabIndex = 18
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuenta, "")
        '
        '_lblEtiqueta_14
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_14, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_14, False)
        Me._lblEtiqueta_14.AutoSize = True
        Me._lblEtiqueta_14.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_14, "Default")
        Me._lblEtiqueta_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_14.Enabled = False
        Me._lblEtiqueta_14.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_14.Location = New System.Drawing.Point(294, 12)
        Me._lblEtiqueta_14.Name = "_lblEtiqueta_14"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_14, "508648")
        Me._lblEtiqueta_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_14.Size = New System.Drawing.Size(47, 13)
        Me._lblEtiqueta_14.TabIndex = 43
        Me._lblEtiqueta_14.Text = "*No. Cta"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_14, "")
        '
        '_Label6_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Label6_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._Label6_2, False)
        Me._Label6_2.AutoSize = True
        Me._Label6_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._Label6_2, "Default")
        Me._Label6_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label6_2.Enabled = False
        Me._Label6_2.ForeColor = System.Drawing.Color.Navy
        Me._Label6_2.Location = New System.Drawing.Point(10, 12)
        Me._Label6_2.Name = "_Label6_2"
        Me.COBISResourceProvider.SetResourceID(Me._Label6_2, "5048")
        Me._Label6_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label6_2.Size = New System.Drawing.Size(57, 13)
        Me._Label6_2.TabIndex = 42
        Me._Label6_2.Text = "*Producto:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Label6_2, "")
        '
        '_Label7_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Label7_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._Label7_2, False)
        Me._Label7_2.AutoSize = True
        Me._Label7_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._Label7_2, "Default")
        Me._Label7_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label7_2.Enabled = False
        Me._Label7_2.ForeColor = System.Drawing.Color.Navy
        Me._Label7_2.Location = New System.Drawing.Point(10, 35)
        Me._Label7_2.Name = "_Label7_2"
        Me.COBISResourceProvider.SetResourceID(Me._Label7_2, "500163")
        Me._Label7_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label7_2.Size = New System.Drawing.Size(46, 13)
        Me._Label7_2.TabIndex = 39
        Me._Label7_2.Text = "*Cliente:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Label7_2, "")
        '
        '_MhRealValor_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._MhRealValor_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._MhRealValor_1, False)
        Me._MhRealValor_1.BackColor = System.Drawing.SystemColors.Window
        Me._MhRealValor_1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._MhRealValor_1, "Default")
        Me._MhRealValor_1.Location = New System.Drawing.Point(367, 56)
        Me._MhRealValor_1.MaxReal = 3.402823E+38!
        Me._MhRealValor_1.MinReal = -3.402823E+38!
        Me._MhRealValor_1.Name = "_MhRealValor_1"
        Me._MhRealValor_1.Separator = True
        Me._MhRealValor_1.Size = New System.Drawing.Size(112, 20)
        Me._MhRealValor_1.TabIndex = 4
        Me._MhRealValor_1.Text = "0.00"
        Me._MhRealValor_1.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me._MhRealValor_1.ValueDouble = 0.0R
        Me._MhRealValor_1.ValueReal = 0.0!
        Me.COBISViewResizer.SetWidthRelativeTo(Me._MhRealValor_1, "")
        '
        '_MhRealValor_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._MhRealValor_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._MhRealValor_0, False)
        Me._MhRealValor_0.BackColor = System.Drawing.SystemColors.Window
        Me._MhRealValor_0.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._MhRealValor_0, "Default")
        Me._MhRealValor_0.Location = New System.Drawing.Point(90, 56)
        Me._MhRealValor_0.MaxReal = 3.402823E+38!
        Me._MhRealValor_0.MinReal = -3.402823E+38!
        Me._MhRealValor_0.Name = "_MhRealValor_0"
        Me._MhRealValor_0.Separator = True
        Me._MhRealValor_0.Size = New System.Drawing.Size(112, 20)
        Me._MhRealValor_0.TabIndex = 3
        Me._MhRealValor_0.Text = "0.00"
        Me._MhRealValor_0.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me._MhRealValor_0.ValueDouble = 0.0R
        Me._MhRealValor_0.ValueReal = 0.0!
        Me.COBISViewResizer.SetWidthRelativeTo(Me._MhRealValor_0, "")
        '
        'ChkFiltros
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.ChkFiltros, False)
        Me.COBISViewResizer.SetAutoResize(Me.ChkFiltros, False)
        Me.ChkFiltros.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.ChkFiltros, "Default")
        Me.ChkFiltros.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkFiltros.ForeColor = System.Drawing.Color.Maroon
        Me.ChkFiltros.Location = New System.Drawing.Point(15, 84)
        Me.ChkFiltros.Name = "ChkFiltros"
        Me.COBISResourceProvider.SetResourceID(Me.ChkFiltros, "508751")
        Me.ChkFiltros.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkFiltros.Size = New System.Drawing.Size(137, 18)
        Me.ChkFiltros.TabIndex = 5
        Me.ChkFiltros.Text = "*[No] Filtros Especiales"
        Me.ChkFiltros.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.ChkFiltros, "")
        '
        'txtOficRecep
        '
        Me.txtOficRecep.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtOficRecep, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtOficRecep, False)
        Me.txtOficRecep.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtOficRecep, "Default")
        Me.txtOficRecep.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtOficRecep.Location = New System.Drawing.Point(90, 10)
        Me.txtOficRecep.MaxLength = 5
        Me.txtOficRecep.Name = "txtOficRecep"
        Me.txtOficRecep.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtOficRecep.Size = New System.Drawing.Size(62, 20)
        Me.txtOficRecep.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtOficRecep, "")
        '
        'mskFechaIni
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskFechaIni, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskFechaIni, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskFechaIni, "Default")
        Me.mskFechaIni.DateType = COBISCorp.Framework.UI.Components.ENUM_DATE.dd_mm_yyyy
        Me.mskFechaIni.Length = CType(64, Short)
        Me.mskFechaIni.Location = New System.Drawing.Point(90, 33)
        Me.mskFechaIni.Mask = "##/##/####"
        Me.mskFechaIni.MaskType = COBISCorp.Framework.UI.Components.ENUM_MASK.[Date]
        Me.mskFechaIni.MaxReal = 3.402823E+38!
        Me.mskFechaIni.MinReal = -3.402823E+38!
        Me.mskFechaIni.Name = "mskFechaIni"
        Me.mskFechaIni.Size = New System.Drawing.Size(112, 20)
        Me.mskFechaIni.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskFechaIni, "")
        '
        'mskFechaFin
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskFechaFin, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskFechaFin, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskFechaFin, "Default")
        Me.mskFechaFin.DateType = COBISCorp.Framework.UI.Components.ENUM_DATE.dd_mm_yyyy
        Me.mskFechaFin.Length = CType(64, Short)
        Me.mskFechaFin.Location = New System.Drawing.Point(367, 33)
        Me.mskFechaFin.Mask = "##/##/####"
        Me.mskFechaFin.MaskType = COBISCorp.Framework.UI.Components.ENUM_MASK.[Date]
        Me.mskFechaFin.MaxReal = 3.402823E+38!
        Me.mskFechaFin.MinReal = -3.402823E+38!
        Me.mskFechaFin.Name = "mskFechaFin"
        Me.mskFechaFin.Size = New System.Drawing.Size(112, 20)
        Me.mskFechaFin.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskFechaFin, "")
        '
        'grdProductos
        '
        Me.grdProductos._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdProductos, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdProductos, False)
        Me.grdProductos.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdProductos.Clip = ""
        Me.grdProductos.Col = CType(1, Short)
        Me.grdProductos.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdProductos.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdProductos.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdProductos, "Default")
        Me.grdProductos.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdProductos, True)
        Me.grdProductos.FixedCols = CType(1, Short)
        Me.grdProductos.FixedRows = CType(1, Short)
        Me.grdProductos.ForeColor = System.Drawing.Color.Black
        Me.grdProductos.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdProductos.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdProductos.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdProductos.HighLight = True
        Me.grdProductos.Location = New System.Drawing.Point(483, 241)
        Me.grdProductos.Name = "grdProductos"
        Me.grdProductos.Picture = Nothing
        Me.grdProductos.Row = CType(1, Short)
        Me.grdProductos.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdProductos.Size = New System.Drawing.Size(33, 30)
        Me.grdProductos.Sort = CType(2, Short)
        Me.grdProductos.TabIndex = 41
        Me.grdProductos.TopRow = CType(1, Short)
        Me.grdProductos.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdProductos, "")
        '
        'lblOfiRecep
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblOfiRecep, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblOfiRecep, False)
        Me.lblOfiRecep.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblOfiRecep.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblOfiRecep, "Default")
        Me.lblOfiRecep.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblOfiRecep.Location = New System.Drawing.Point(155, 10)
        Me.lblOfiRecep.Name = "lblOfiRecep"
        Me.lblOfiRecep.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblOfiRecep.Size = New System.Drawing.Size(385, 20)
        Me.lblOfiRecep.TabIndex = 40
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblOfiRecep, "")
        '
        '_lblEtiqueta_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_4, False)
        Me._lblEtiqueta_4.AutoSize = True
        Me._lblEtiqueta_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_4, "Default")
        Me._lblEtiqueta_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_4.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_4.Location = New System.Drawing.Point(287, 56)
        Me._lblEtiqueta_4.Name = "_lblEtiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_4, "502777")
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(60, 13)
        Me._lblEtiqueta_4.TabIndex = 32
        Me._lblEtiqueta_4.Text = "*Valor Final"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_4, "")
        '
        '_lblEtiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.AutoSize = True
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(10, 56)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "502776")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(64, 13)
        Me._lblEtiqueta_3.TabIndex = 31
        Me._lblEtiqueta_3.Text = "*Valor inicial"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        '_lblEtiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_2, False)
        Me._lblEtiqueta_2.AutoSize = True
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(287, 33)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "508569")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(66, 13)
        Me._lblEtiqueta_2.TabIndex = 30
        Me._lblEtiqueta_2.Text = "*Fecha Final"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.AutoSize = True
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(10, 33)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "508572")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(71, 13)
        Me._lblEtiqueta_1.TabIndex = 29
        Me._lblEtiqueta_1.Text = "*Fecha Inicial"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
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
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "2420")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(67, 20)
        Me._lblEtiqueta_0.TabIndex = 27
        Me._lblEtiqueta_0.Text = "*Oficina"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        '_cmbTipo_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmbTipo_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmbTipo_1, False)
        Me._cmbTipo_1.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._cmbTipo_1, "Default")
        Me._cmbTipo_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._cmbTipo_1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._cmbTipo_1.ForeColor = System.Drawing.SystemColors.WindowText
        Me._cmbTipo_1.Location = New System.Drawing.Point(334, 11)
        Me._cmbTipo_1.Name = "_cmbTipo_1"
        Me._cmbTipo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmbTipo_1.Size = New System.Drawing.Size(172, 21)
        Me._cmbTipo_1.TabIndex = 45
        Me._cmbTipo_1.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmbTipo_1, "")
        '
        '_cmbTipo_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmbTipo_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmbTipo_2, False)
        Me._cmbTipo_2.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._cmbTipo_2, "Default")
        Me._cmbTipo_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._cmbTipo_2.ForeColor = System.Drawing.SystemColors.WindowText
        Me._cmbTipo_2.Location = New System.Drawing.Point(276, 11)
        Me._cmbTipo_2.Name = "_cmbTipo_2"
        Me._cmbTipo_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmbTipo_2.Size = New System.Drawing.Size(52, 21)
        Me._cmbTipo_2.TabIndex = 44
        Me._cmbTipo_2.Text = "cmbTipo"
        Me._cmbTipo_2.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmbTipo_2, "")
        '
        'grdChequeras
        '
        Me.grdChequeras._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdChequeras, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdChequeras, False)
        Me.grdChequeras.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdChequeras.Clip = ""
        Me.grdChequeras.Col = CType(1, Short)
        Me.grdChequeras.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdChequeras.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdChequeras.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdChequeras, "Default")
        Me.grdChequeras.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdChequeras, True)
        Me.grdChequeras.FixedCols = CType(1, Short)
        Me.grdChequeras.FixedRows = CType(1, Short)
        Me.grdChequeras.ForeColor = System.Drawing.Color.Black
        Me.grdChequeras.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdChequeras.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdChequeras.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdChequeras.HighLight = True
        Me.grdChequeras.Location = New System.Drawing.Point(6, 11)
        Me.grdChequeras.Name = "grdChequeras"
        Me.grdChequeras.Picture = Nothing
        Me.grdChequeras.Row = CType(1, Short)
        Me.grdChequeras.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdChequeras.Size = New System.Drawing.Size(535, 119)
        Me.grdChequeras.Sort = CType(2, Short)
        Me.grdChequeras.TabIndex = 26
        Me.grdChequeras.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdChequeras, "")
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
        Me._cmdBoton_3.Location = New System.Drawing.Point(681, 377)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 24
        Me._cmdBoton_3.TabStop = False
        Me._cmdBoton_3.Text = "*&Salir"
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
        Me._cmdBoton_2.Location = New System.Drawing.Point(681, 321)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 23
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Text = "*&Limpiar"
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(681, 34)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 20
        Me._cmdBoton_1.TabStop = False
        Me._cmdBoton_1.Text = "*&Buscar"
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
        Me._cmdBoton_0.Enabled = False
        Me._cmdBoton_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_0.Location = New System.Drawing.Point(681, 86)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 21
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Text = "*Sig&tes."
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
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
        Me._cmdBoton_4.Location = New System.Drawing.Point(681, 138)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(58, 51)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 22
        Me._cmdBoton_4.TabStop = False
        Me._cmdBoton_4.Text = "*&Excel"
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me.Frame1)
        Me.PFormas.Controls.Add(Me._cmdBoton_3)
        Me.PFormas.Controls.Add(Me._cmdBoton_4)
        Me.PFormas.Controls.Add(Me._cmdBoton_2)
        Me.PFormas.Controls.Add(Me._cmdBoton_0)
        Me.PFormas.Controls.Add(Me._cmdBoton_1)
        Me.PFormas.Controls.Add(Me.grdProductos)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(573, 584)
        Me.PFormas.TabIndex = 29
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me._cmbTipo_2)
        Me.GroupBox1.Controls.Add(Me._cmbTipo_1)
        Me.GroupBox1.Controls.Add(Me.grdChequeras)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 438)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(546, 135)
        Me.GroupBox1.TabIndex = 27
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'TSBBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBBotones, "Default")
        Me.TSBBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBSiguientes, Me.TSBExcel, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBBotones.Name = "TSBBotones"
        Me.TSBBotones.Size = New System.Drawing.Size(605, 25)
        Me.TSBBotones.TabIndex = 30
        Me.TSBBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBBotones, "")
        '
        'TSBBuscar
        '
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.Size = New System.Drawing.Size(67, 22)
        Me.TSBBuscar.Text = "*&Buscar"
        '
        'TSBSiguientes
        '
        Me.TSBSiguientes.Image = CType(resources.GetObject("TSBSiguientes.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguientes, "2001")
        Me.TSBSiguientes.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguientes.Name = "TSBSiguientes"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguientes, "500012")
        Me.TSBSiguientes.Size = New System.Drawing.Size(86, 22)
        Me.TSBSiguientes.Text = "*Siguien&tes"
        '
        'TSBExcel
        '
        Me.TSBExcel.Image = CType(resources.GetObject("TSBExcel.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBExcel, "2500")
        Me.TSBExcel.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBExcel.Name = "TSBExcel"
        Me.COBISResourceProvider.SetResourceID(Me.TSBExcel, "501619")
        Me.TSBExcel.Size = New System.Drawing.Size(58, 22)
        Me.TSBExcel.Text = "*&Excel"
        '
        'TSBLimpiar
        '
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
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "2008")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'Pforma
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Pforma, False)
        Me.COBISViewResizer.SetAutoResize(Me.Pforma, False)
        Me.COBISStyleProvider.SetControlStyle(Me.Pforma, "Default")
        Me.Pforma.Location = New System.Drawing.Point(0, 0)
        Me.Pforma.Name = "Pforma"
        Me.Pforma.Size = New System.Drawing.Size(200, 110)
        Me.Pforma.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Pforma, "")
        '
        'Ftran2797Class
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me.TSBBotones)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Location = New System.Drawing.Point(5, 35)
        Me.Name = "Ftran2797Class"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(605, 623)
        Me.Tag = "2797"
        Me.Text = "Consulta Registro de Operaciones en Efectivo "
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.Frame1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame1.ResumeLayout(False)
        Me.Frame1.PerformLayout()
        Me.TableLayoutPanel1.ResumeLayout(False)
        CType(Me._Frame2_0, System.ComponentModel.ISupportInitialize).EndInit()
        Me._Frame2_0.ResumeLayout(False)
        Me._Frame2_0.PerformLayout()
        CType(Me._Frame2_1, System.ComponentModel.ISupportInitialize).EndInit()
        Me._Frame2_1.ResumeLayout(False)
        Me._Frame2_1.PerformLayout()
        CType(Me._Frame2_3, System.ComponentModel.ISupportInitialize).EndInit()
        Me._Frame2_3.ResumeLayout(False)
        Me._Frame2_3.PerformLayout()
        CType(Me._Frame2_2, System.ComponentModel.ISupportInitialize).EndInit()
        Me._Frame2_2.ResumeLayout(False)
        Me._Frame2_2.PerformLayout()
        CType(Me.grdProductos, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.grdChequeras, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.TSBBotones.ResumeLayout(False)
        Me.TSBBotones.PerformLayout()
        CType(Me.Pforma, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(14) = _lblEtiqueta_14
        Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(0) = _lblEtiqueta_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(4) = _cmdBoton_4
    End Sub
    Sub Initializecmbide()
        Me.cmbide(1) = _cmbide_1
        Me.cmbide(0) = _cmbide_0
        Me.cmbide(3) = _cmbide_3
    End Sub
    Sub InitializecmbTipo()
        Me.cmbTipo(1) = _cmbTipo_1
        Me.cmbTipo(2) = _cmbTipo_2
        Me.cmbTipo(0) = _cmbTipo_0
    End Sub
    Sub InitializeOption1()
        Me.Option1(3) = _Option1_3
        Me.Option1(2) = _Option1_2
        Me.Option1(1) = _Option1_1
        Me.Option1(0) = _Option1_0
    End Sub
    Sub InitializeMhRealValor()
        Me.MhRealValor(1) = _MhRealValor_1
        Me.MhRealValor(0) = _MhRealValor_0
    End Sub
    Sub InitializeMaskpers_ced_nit()
        Me.Maskpers_ced_nit(1) = _Maskpers_ced_nit_1
        Me.Maskpers_ced_nit(0) = _Maskpers_ced_nit_0
        Me.Maskpers_ced_nit(3) = _Maskpers_ced_nit_3
    End Sub
    'Sub InitializeLine1()
    '    Me.Line1(1) = _Line1_1
    '    Me.Line1(0) = _Line1_0
    'End Sub
    Sub InitializeLabel7()
        Me.Label7(2) = _Label7_2
        Me.Label7(1) = _Label7_1
        Me.Label7(0) = _Label7_0
        Me.Label7(3) = _Label7_3
    End Sub
    Sub InitializeLabel6()
        Me.Label6(2) = _Label6_2
        Me.Label6(1) = _Label6_1
        Me.Label6(0) = _Label6_0
        Me.Label6(3) = _Label6_3
    End Sub
    Sub InitializeFrame2()
        Me.Frame2(2) = _Frame2_2
        Me.Frame2(1) = _Frame2_1
        Me.Frame2(0) = _Frame2_0
        Me.Frame2(3) = _Frame2_3
    End Sub
    Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguientes As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBExcel As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TableLayoutPanel1 As System.Windows.Forms.TableLayoutPanel
#End Region
End Class


