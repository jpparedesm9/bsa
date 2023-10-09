<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FReversosClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    'UserControl overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FReversosClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSiguiente = New System.Windows.Forms.ToolStripButton()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.ugbBuscar = New Infragistics.Win.Misc.UltraGroupBox()
        Me.pnlMoneda = New System.Windows.Forms.Panel()
        Me.txtNomMoneda = New System.Windows.Forms.TextBox()
        Me.Label10 = New System.Windows.Forms.Label()
        Me.txtCodMoneda = New COBISCorp.Framework.UI.Components.COBISValidTextBox()
        Me.pnlCuenta = New System.Windows.Forms.Panel()
        Me.txtNomCuenta = New System.Windows.Forms.TextBox()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.mskCuenta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.pnlValor = New System.Windows.Forms.Panel()
        Me.mskValorFin = New COBISCorp.Framework.UI.Components.COBISMaskedInBox()
        Me.mskValorIni = New COBISCorp.Framework.UI.Components.COBISMaskedInBox()
        Me.Label8 = New System.Windows.Forms.Label()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.pnlHora = New System.Windows.Forms.Panel()
        Me.mskHoraFin = New System.Windows.Forms.MaskedTextBox()
        Me.mskHoraIni = New System.Windows.Forms.MaskedTextBox()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.pnlNemonico = New System.Windows.Forms.Panel()
        Me.txtNemonico = New COBISCorp.Framework.UI.Components.COBISValidTextBox()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.pnlSecuencial = New System.Windows.Forms.Panel()
        Me.txtSecFin = New COBISCorp.Framework.UI.Components.COBISValidTextBox()
        Me.txtSecIni = New COBISCorp.Framework.UI.Components.COBISValidTextBox()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.pnlUsuario = New System.Windows.Forms.Panel()
        Me.txtUsrCodigo = New COBISCorp.Framework.UI.Components.COBISValidTextBox()
        Me.txtUsrNombre = New System.Windows.Forms.TextBox()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.chkMoneda = New System.Windows.Forms.CheckBox()
        Me.chkCuenta = New System.Windows.Forms.CheckBox()
        Me.chkValor = New System.Windows.Forms.CheckBox()
        Me.chkHora = New System.Windows.Forms.CheckBox()
        Me.chkNemonico = New System.Windows.Forms.CheckBox()
        Me.chkSecuencial = New System.Windows.Forms.CheckBox()
        Me.chkUsuario = New System.Windows.Forms.CheckBox()
        Me.ugbTransacciones = New Infragistics.Win.Misc.UltraGroupBox()
        Me.grdTransacciones = New COBISCorp.Framework.UI.Components.COBISSpread()
        Me.grdTransacciones_Sheet1 = New FarPoint.Win.Spread.SheetView()
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.TSBotones.SuspendLayout()
        CType(Me.ugbBuscar, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.ugbBuscar.SuspendLayout()
        Me.pnlMoneda.SuspendLayout()
        Me.pnlCuenta.SuspendLayout()
        Me.pnlValor.SuspendLayout()
        Me.pnlHora.SuspendLayout()
        Me.pnlNemonico.SuspendLayout()
        Me.pnlSecuencial.SuspendLayout()
        Me.pnlUsuario.SuspendLayout()
        CType(Me.ugbTransacciones, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.ugbTransacciones.SuspendLayout()
        CType(Me.grdTransacciones, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.grdTransacciones_Sheet1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'COBISViewResizer
        '
        Me.COBISViewResizer.AutoRelocateControls = False
        Me.COBISViewResizer.AutoResizeControls = False
        Me.COBISViewResizer.EnabledResize = True
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBSiguiente, Me.TSBTransmitir, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(658, 25)
        Me.TSBotones.TabIndex = 0
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBBuscar
        '
        Me.TSBBuscar.ForeColor = System.Drawing.Color.Black
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.Size = New System.Drawing.Size(67, 22)
        Me.TSBBuscar.Text = "*&Buscar"
        '
        'TSBSiguiente
        '
        Me.TSBSiguiente.ForeColor = System.Drawing.Color.Black
        Me.TSBSiguiente.Image = CType(resources.GetObject("TSBSiguiente.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguiente, "2001")
        Me.TSBSiguiente.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguiente.Name = "TSBSiguiente"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguiente, "2306")
        Me.TSBSiguiente.Size = New System.Drawing.Size(81, 22)
        Me.TSBSiguiente.Text = "*Si&guiente"
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.ForeColor = System.Drawing.Color.Black
        Me.TSBTransmitir.Image = CType(resources.GetObject("TSBTransmitir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBTransmitir, "2501")
        Me.TSBTransmitir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBTransmitir.Name = "TSBTransmitir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.Size = New System.Drawing.Size(86, 22)
        Me.TSBTransmitir.Text = "*&Transmitir"
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.ForeColor = System.Drawing.Color.Black
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
        Me.TSBSalir.ForeColor = System.Drawing.Color.Black
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1006")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'ugbBuscar
        '
        Me.ugbBuscar.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.COBISViewResizer.SetAutoRelocate(Me.ugbBuscar, False)
        Me.COBISViewResizer.SetAutoResize(Me.ugbBuscar, False)
        Me.ugbBuscar.BackColorInternal = System.Drawing.Color.White
        Me.ugbBuscar.Controls.Add(Me.pnlMoneda)
        Me.ugbBuscar.Controls.Add(Me.pnlCuenta)
        Me.ugbBuscar.Controls.Add(Me.pnlValor)
        Me.ugbBuscar.Controls.Add(Me.pnlHora)
        Me.ugbBuscar.Controls.Add(Me.pnlNemonico)
        Me.ugbBuscar.Controls.Add(Me.pnlSecuencial)
        Me.ugbBuscar.Controls.Add(Me.pnlUsuario)
        Me.ugbBuscar.Controls.Add(Me.chkMoneda)
        Me.ugbBuscar.Controls.Add(Me.chkCuenta)
        Me.ugbBuscar.Controls.Add(Me.chkValor)
        Me.ugbBuscar.Controls.Add(Me.chkHora)
        Me.ugbBuscar.Controls.Add(Me.chkNemonico)
        Me.ugbBuscar.Controls.Add(Me.chkSecuencial)
        Me.ugbBuscar.Controls.Add(Me.chkUsuario)
        Me.COBISStyleProvider.SetControlStyle(Me.ugbBuscar, "Default")
        Me.ugbBuscar.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ugbBuscar.Location = New System.Drawing.Point(8, 33)
        Me.ugbBuscar.Name = "ugbBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.ugbBuscar, "5089")
        Me.ugbBuscar.Size = New System.Drawing.Size(643, 248)
        Me.ugbBuscar.TabIndex = 1
        Me.ugbBuscar.Text = "*Criterios de búsqueda"
        Me.ugbBuscar.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.ugbBuscar, "")
        '
        'pnlMoneda
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.pnlMoneda, False)
        Me.COBISViewResizer.SetAutoResize(Me.pnlMoneda, False)
        Me.pnlMoneda.BackColor = System.Drawing.Color.Transparent
        Me.pnlMoneda.Controls.Add(Me.txtNomMoneda)
        Me.pnlMoneda.Controls.Add(Me.Label10)
        Me.pnlMoneda.Controls.Add(Me.txtCodMoneda)
        Me.COBISStyleProvider.SetControlStyle(Me.pnlMoneda, "Default")
        Me.pnlMoneda.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.pnlMoneda.Location = New System.Drawing.Point(200, 210)
        Me.pnlMoneda.Name = "pnlMoneda"
        Me.pnlMoneda.Size = New System.Drawing.Size(435, 30)
        Me.pnlMoneda.TabIndex = 13
        Me.pnlMoneda.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.pnlMoneda, "")
        '
        'txtNomMoneda
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.txtNomMoneda, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtNomMoneda, False)
        Me.COBISStyleProvider.SetControlStyle(Me.txtNomMoneda, "Default")
        Me.txtNomMoneda.Location = New System.Drawing.Point(168, 5)
        Me.txtNomMoneda.Name = "txtNomMoneda"
        Me.txtNomMoneda.ReadOnly = True
        Me.txtNomMoneda.Size = New System.Drawing.Size(260, 20)
        Me.txtNomMoneda.TabIndex = 1
        Me.txtNomMoneda.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtNomMoneda, "")
        '
        'Label10
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label10, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label10, False)
        Me.Label10.AutoSize = True
        Me.COBISStyleProvider.SetControlStyle(Me.Label10, "Default")
        Me.Label10.Location = New System.Drawing.Point(12, 8)
        Me.Label10.Name = "Label10"
        Me.COBISResourceProvider.SetResourceID(Me.Label10, "5209")
        Me.Label10.Size = New System.Drawing.Size(53, 13)
        Me.Label10.TabIndex = 110
        Me.Label10.Text = "*Moneda:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label10, "")
        '
        'txtCodMoneda
        '
        Me.txtCodMoneda.AsociatedLabelIndex = CType(0, Short)
        Me.COBISViewResizer.SetAutoRelocate(Me.txtCodMoneda, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtCodMoneda, False)
        Me.txtCodMoneda.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.txtCodMoneda, "Default")
        Me.COBISStyleProvider.SetEnableStyle(Me.txtCodMoneda, True)
        Me.txtCodMoneda.Error = CType(0, Short)
        Me.txtCodMoneda.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtCodMoneda.HelpLine = Nothing
        Me.txtCodMoneda.Location = New System.Drawing.Point(112, 5)
        Me.txtCodMoneda.MaxLength = CType(0, Short)
        Me.txtCodMoneda.MinChar = CType(0, Short)
        Me.txtCodMoneda.Name = "txtCodMoneda"
        Me.txtCodMoneda.Pendiente = Nothing
        Me.txtCodMoneda.Range = Nothing
        Me.txtCodMoneda.Size = New System.Drawing.Size(50, 20)
        Me.txtCodMoneda.TabIndex = 0
        Me.txtCodMoneda.TableName = Nothing
        Me.txtCodMoneda.TitleCatalog = Nothing
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtCodMoneda, "")
        '
        'pnlCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.pnlCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.pnlCuenta, False)
        Me.pnlCuenta.BackColor = System.Drawing.Color.Transparent
        Me.pnlCuenta.Controls.Add(Me.txtNomCuenta)
        Me.pnlCuenta.Controls.Add(Me.Label9)
        Me.pnlCuenta.Controls.Add(Me.mskCuenta)
        Me.COBISStyleProvider.SetControlStyle(Me.pnlCuenta, "Default")
        Me.pnlCuenta.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.pnlCuenta.Location = New System.Drawing.Point(200, 179)
        Me.pnlCuenta.Name = "pnlCuenta"
        Me.pnlCuenta.Size = New System.Drawing.Size(435, 30)
        Me.pnlCuenta.TabIndex = 11
        Me.pnlCuenta.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.pnlCuenta, "")
        '
        'txtNomCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.txtNomCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtNomCuenta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.txtNomCuenta, "Default")
        Me.txtNomCuenta.Location = New System.Drawing.Point(228, 5)
        Me.txtNomCuenta.Name = "txtNomCuenta"
        Me.txtNomCuenta.ReadOnly = True
        Me.txtNomCuenta.Size = New System.Drawing.Size(200, 20)
        Me.txtNomCuenta.TabIndex = 1
        Me.txtNomCuenta.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtNomCuenta, "")
        '
        'Label9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label9, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label9, False)
        Me.Label9.AutoSize = True
        Me.COBISStyleProvider.SetControlStyle(Me.Label9, "Default")
        Me.Label9.Location = New System.Drawing.Point(12, 8)
        Me.Label9.Name = "Label9"
        Me.COBISResourceProvider.SetResourceID(Me.Label9, "508653")
        Me.Label9.Size = New System.Drawing.Size(91, 13)
        Me.Label9.TabIndex = 109
        Me.Label9.Text = "*Num. de Cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label9, "")
        '
        'mskCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuenta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuenta, "Default")
        Me.mskCuenta.Length = CType(64, Short)
        Me.mskCuenta.Location = New System.Drawing.Point(112, 5)
        Me.mskCuenta.MaxReal = 3.402823E+38!
        Me.mskCuenta.MinReal = -3.402823E+38!
        Me.mskCuenta.Name = "mskCuenta"
        Me.mskCuenta.Size = New System.Drawing.Size(110, 20)
        Me.mskCuenta.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuenta, "")
        '
        'pnlValor
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.pnlValor, False)
        Me.COBISViewResizer.SetAutoResize(Me.pnlValor, False)
        Me.pnlValor.BackColor = System.Drawing.Color.Transparent
        Me.pnlValor.Controls.Add(Me.mskValorFin)
        Me.pnlValor.Controls.Add(Me.mskValorIni)
        Me.pnlValor.Controls.Add(Me.Label8)
        Me.pnlValor.Controls.Add(Me.Label7)
        Me.COBISStyleProvider.SetControlStyle(Me.pnlValor, "Default")
        Me.pnlValor.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.pnlValor.Location = New System.Drawing.Point(200, 148)
        Me.pnlValor.Name = "pnlValor"
        Me.pnlValor.Size = New System.Drawing.Size(435, 30)
        Me.pnlValor.TabIndex = 9
        Me.pnlValor.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.pnlValor, "")
        '
        'mskValorFin
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskValorFin, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskValorFin, False)
        Me.mskValorFin.BackColor = System.Drawing.SystemColors.Window
        Me.mskValorFin.ClipMode = COBISCorp.Framework.UI.Components.ENUM_CLIPMODE.Include_Literals_on_cut_copy
        Me.mskValorFin.ClipText = "0.00"
        Me.COBISStyleProvider.SetControlStyle(Me.mskValorFin, "Default")
        Me.mskValorFin.Cuantas = 0
        Me.mskValorFin.DateString = "_.$"
        Me.mskValorFin.DateSybase = Nothing
        Me.mskValorFin.Decimals = CType(2, Short)
        Me.mskValorFin.Errores = CType(0, Short)
        Me.mskValorFin.Fin = 6
        Me.mskValorFin.FormattedText = Nothing
        Me.mskValorFin.HelpLine = Nothing
        Me.mskValorFin.hWnd = 0
        Me.mskValorFin.Location = New System.Drawing.Point(273, 5)
        Me.mskValorFin.Mask = " "
        Me.mskValorFin.MaxReal = 1.0E+15!
        Me.mskValorFin.MinReal = 0.0!
        Me.mskValorFin.Name = "mskValorFin"
        Me.mskValorFin.Nullable = False
        Me.mskValorFin.Separator = True
        Me.mskValorFin.Size = New System.Drawing.Size(110, 20)
        Me.mskValorFin.StringIndex = CType(0, Short)
        Me.mskValorFin.TabIndex = 1
        Me.mskValorFin.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskValorFin, "")
        '
        'mskValorIni
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskValorIni, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskValorIni, False)
        Me.mskValorIni.BackColor = System.Drawing.SystemColors.Window
        Me.mskValorIni.ClipMode = COBISCorp.Framework.UI.Components.ENUM_CLIPMODE.Include_Literals_on_cut_copy
        Me.mskValorIni.ClipText = "0.00"
        Me.COBISStyleProvider.SetControlStyle(Me.mskValorIni, "Default")
        Me.mskValorIni.Cuantas = 0
        Me.mskValorIni.DateString = "_.$"
        Me.mskValorIni.DateSybase = Nothing
        Me.mskValorIni.Decimals = CType(2, Short)
        Me.mskValorIni.Errores = CType(0, Short)
        Me.mskValorIni.Fin = 6
        Me.mskValorIni.FormattedText = Nothing
        Me.mskValorIni.HelpLine = Nothing
        Me.mskValorIni.hWnd = 0
        Me.mskValorIni.Location = New System.Drawing.Point(112, 5)
        Me.mskValorIni.Mask = " "
        Me.mskValorIni.MaxReal = 1.0E+15!
        Me.mskValorIni.MinReal = 0.0!
        Me.mskValorIni.Name = "mskValorIni"
        Me.mskValorIni.Nullable = False
        Me.mskValorIni.Separator = True
        Me.mskValorIni.Size = New System.Drawing.Size(110, 20)
        Me.mskValorIni.StringIndex = CType(0, Short)
        Me.mskValorIni.TabIndex = 0
        Me.mskValorIni.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskValorIni, "")
        '
        'Label8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label8, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label8, False)
        Me.Label8.AutoSize = True
        Me.COBISStyleProvider.SetControlStyle(Me.Label8, "Default")
        Me.Label8.Location = New System.Drawing.Point(225, 8)
        Me.Label8.Name = "Label8"
        Me.COBISResourceProvider.SetResourceID(Me.Label8, "502208")
        Me.Label8.Size = New System.Drawing.Size(42, 13)
        Me.Label8.TabIndex = 109
        Me.Label8.Text = "*Hasta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label8, "")
        '
        'Label7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label7, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label7, False)
        Me.Label7.AutoSize = True
        Me.COBISStyleProvider.SetControlStyle(Me.Label7, "Default")
        Me.Label7.Location = New System.Drawing.Point(12, 8)
        Me.Label7.Name = "Label7"
        Me.COBISResourceProvider.SetResourceID(Me.Label7, "502209")
        Me.Label7.Size = New System.Drawing.Size(45, 13)
        Me.Label7.TabIndex = 108
        Me.Label7.Text = "*Desde:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label7, "")
        '
        'pnlHora
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.pnlHora, False)
        Me.COBISViewResizer.SetAutoResize(Me.pnlHora, False)
        Me.pnlHora.BackColor = System.Drawing.Color.Transparent
        Me.pnlHora.Controls.Add(Me.mskHoraFin)
        Me.pnlHora.Controls.Add(Me.mskHoraIni)
        Me.pnlHora.Controls.Add(Me.Label6)
        Me.pnlHora.Controls.Add(Me.Label5)
        Me.COBISStyleProvider.SetControlStyle(Me.pnlHora, "Default")
        Me.pnlHora.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.pnlHora.Location = New System.Drawing.Point(200, 117)
        Me.pnlHora.Name = "pnlHora"
        Me.pnlHora.Size = New System.Drawing.Size(435, 30)
        Me.pnlHora.TabIndex = 7
        Me.pnlHora.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.pnlHora, "")
        '
        'mskHoraFin
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskHoraFin, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskHoraFin, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskHoraFin, "Default")
        Me.mskHoraFin.Location = New System.Drawing.Point(273, 5)
        Me.mskHoraFin.Mask = "##:##"
        Me.mskHoraFin.Name = "mskHoraFin"
        Me.mskHoraFin.Size = New System.Drawing.Size(50, 20)
        Me.mskHoraFin.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskHoraFin, "")
        '
        'mskHoraIni
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskHoraIni, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskHoraIni, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskHoraIni, "Default")
        Me.mskHoraIni.Location = New System.Drawing.Point(112, 5)
        Me.mskHoraIni.Mask = "##:##"
        Me.mskHoraIni.Name = "mskHoraIni"
        Me.mskHoraIni.Size = New System.Drawing.Size(50, 20)
        Me.mskHoraIni.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskHoraIni, "")
        '
        'Label6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label6, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label6, False)
        Me.Label6.AutoSize = True
        Me.COBISStyleProvider.SetControlStyle(Me.Label6, "Default")
        Me.Label6.Location = New System.Drawing.Point(225, 8)
        Me.Label6.Name = "Label6"
        Me.COBISResourceProvider.SetResourceID(Me.Label6, "509521")
        Me.Label6.Size = New System.Drawing.Size(28, 13)
        Me.Label6.TabIndex = 108
        Me.Label6.Text = "*Fin:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label6, "")
        '
        'Label5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label5, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label5, False)
        Me.Label5.AutoSize = True
        Me.COBISStyleProvider.SetControlStyle(Me.Label5, "Default")
        Me.Label5.Location = New System.Drawing.Point(12, 8)
        Me.Label5.Name = "Label5"
        Me.COBISResourceProvider.SetResourceID(Me.Label5, "509520")
        Me.Label5.Size = New System.Drawing.Size(39, 13)
        Me.Label5.TabIndex = 107
        Me.Label5.Text = "*Inicio:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label5, "")
        '
        'pnlNemonico
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.pnlNemonico, False)
        Me.COBISViewResizer.SetAutoResize(Me.pnlNemonico, False)
        Me.pnlNemonico.BackColor = System.Drawing.Color.Transparent
        Me.pnlNemonico.Controls.Add(Me.txtNemonico)
        Me.pnlNemonico.Controls.Add(Me.Label4)
        Me.COBISStyleProvider.SetControlStyle(Me.pnlNemonico, "Default")
        Me.pnlNemonico.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.pnlNemonico.Location = New System.Drawing.Point(200, 86)
        Me.pnlNemonico.Name = "pnlNemonico"
        Me.pnlNemonico.Size = New System.Drawing.Size(435, 30)
        Me.pnlNemonico.TabIndex = 5
        Me.pnlNemonico.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.pnlNemonico, "")
        '
        'txtNemonico
        '
        Me.txtNemonico.AsociatedLabelIndex = CType(0, Short)
        Me.COBISViewResizer.SetAutoRelocate(Me.txtNemonico, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtNemonico, False)
        Me.txtNemonico.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.txtNemonico, "Default")
        Me.COBISStyleProvider.SetEnableStyle(Me.txtNemonico, True)
        Me.txtNemonico.Error = CType(0, Short)
        Me.txtNemonico.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtNemonico.HelpLine = Nothing
        Me.txtNemonico.Location = New System.Drawing.Point(112, 5)
        Me.txtNemonico.MaxLength = CType(5, Short)
        Me.txtNemonico.MinChar = CType(0, Short)
        Me.txtNemonico.Name = "txtNemonico"
        Me.txtNemonico.Pendiente = Nothing
        Me.txtNemonico.Range = Nothing
        Me.txtNemonico.Size = New System.Drawing.Size(50, 20)
        Me.txtNemonico.TabIndex = 0
        Me.txtNemonico.TableName = Nothing
        Me.txtNemonico.TitleCatalog = Nothing
        Me.txtNemonico.Type = COBISCorp.Framework.UI.Components.ENUM_TYPE._Smallint
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtNemonico, "")
        '
        'Label4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label4, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label4, False)
        Me.Label4.AutoSize = True
        Me.COBISStyleProvider.SetControlStyle(Me.Label4, "Default")
        Me.Label4.Location = New System.Drawing.Point(12, 8)
        Me.Label4.Name = "Label4"
        Me.COBISResourceProvider.SetResourceID(Me.Label4, "500379")
        Me.Label4.Size = New System.Drawing.Size(94, 13)
        Me.Label4.TabIndex = 107
        Me.Label4.Text = "*Cod. transacción:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label4, "")
        '
        'pnlSecuencial
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.pnlSecuencial, False)
        Me.COBISViewResizer.SetAutoResize(Me.pnlSecuencial, False)
        Me.pnlSecuencial.BackColor = System.Drawing.Color.Transparent
        Me.pnlSecuencial.Controls.Add(Me.txtSecFin)
        Me.pnlSecuencial.Controls.Add(Me.txtSecIni)
        Me.pnlSecuencial.Controls.Add(Me.Label3)
        Me.pnlSecuencial.Controls.Add(Me.Label2)
        Me.COBISStyleProvider.SetControlStyle(Me.pnlSecuencial, "Default")
        Me.pnlSecuencial.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.pnlSecuencial.Location = New System.Drawing.Point(200, 55)
        Me.pnlSecuencial.Name = "pnlSecuencial"
        Me.pnlSecuencial.Size = New System.Drawing.Size(435, 30)
        Me.pnlSecuencial.TabIndex = 3
        Me.pnlSecuencial.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.pnlSecuencial, "")
        '
        'txtSecFin
        '
        Me.txtSecFin.AsociatedLabelIndex = CType(0, Short)
        Me.COBISViewResizer.SetAutoRelocate(Me.txtSecFin, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtSecFin, False)
        Me.txtSecFin.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.txtSecFin, "Default")
        Me.COBISStyleProvider.SetEnableStyle(Me.txtSecFin, True)
        Me.txtSecFin.Error = CType(0, Short)
        Me.txtSecFin.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtSecFin.HelpLine = Nothing
        Me.txtSecFin.Location = New System.Drawing.Point(273, 5)
        Me.txtSecFin.MaxLength = CType(9, Short)
        Me.txtSecFin.MinChar = CType(0, Short)
        Me.txtSecFin.Name = "txtSecFin"
        Me.txtSecFin.Pendiente = Nothing
        Me.txtSecFin.Range = Nothing
        Me.txtSecFin.Size = New System.Drawing.Size(100, 20)
        Me.txtSecFin.TabIndex = 1
        Me.txtSecFin.TableName = Nothing
        Me.txtSecFin.TitleCatalog = Nothing
        Me.txtSecFin.Type = COBISCorp.Framework.UI.Components.ENUM_TYPE._Int
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtSecFin, "")
        '
        'txtSecIni
        '
        Me.txtSecIni.AsociatedLabelIndex = CType(0, Short)
        Me.COBISViewResizer.SetAutoRelocate(Me.txtSecIni, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtSecIni, False)
        Me.txtSecIni.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.txtSecIni, "Default")
        Me.COBISStyleProvider.SetEnableStyle(Me.txtSecIni, True)
        Me.txtSecIni.Error = CType(0, Short)
        Me.txtSecIni.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtSecIni.HelpLine = Nothing
        Me.txtSecIni.Location = New System.Drawing.Point(112, 5)
        Me.txtSecIni.MaxLength = CType(9, Short)
        Me.txtSecIni.MinChar = CType(0, Short)
        Me.txtSecIni.Name = "txtSecIni"
        Me.txtSecIni.Pendiente = Nothing
        Me.txtSecIni.Range = Nothing
        Me.txtSecIni.Size = New System.Drawing.Size(110, 20)
        Me.txtSecIni.TabIndex = 0
        Me.txtSecIni.TableName = Nothing
        Me.txtSecIni.TitleCatalog = Nothing
        Me.txtSecIni.Type = COBISCorp.Framework.UI.Components.ENUM_TYPE._Int
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtSecIni, "")
        '
        'Label3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label3, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label3, False)
        Me.Label3.AutoSize = True
        Me.COBISStyleProvider.SetControlStyle(Me.Label3, "Default")
        Me.Label3.Location = New System.Drawing.Point(225, 8)
        Me.Label3.Name = "Label3"
        Me.COBISResourceProvider.SetResourceID(Me.Label3, "509521")
        Me.Label3.Size = New System.Drawing.Size(28, 13)
        Me.Label3.TabIndex = 107
        Me.Label3.Text = "*Fin:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label3, "")
        '
        'Label2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label2, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label2, False)
        Me.Label2.AutoSize = True
        Me.COBISStyleProvider.SetControlStyle(Me.Label2, "Default")
        Me.Label2.Location = New System.Drawing.Point(12, 8)
        Me.Label2.Name = "Label2"
        Me.COBISResourceProvider.SetResourceID(Me.Label2, "509520")
        Me.Label2.Size = New System.Drawing.Size(39, 13)
        Me.Label2.TabIndex = 106
        Me.Label2.Text = "*Inicio:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label2, "")
        '
        'pnlUsuario
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.pnlUsuario, False)
        Me.COBISViewResizer.SetAutoResize(Me.pnlUsuario, False)
        Me.pnlUsuario.BackColor = System.Drawing.Color.Transparent
        Me.pnlUsuario.Controls.Add(Me.txtUsrCodigo)
        Me.pnlUsuario.Controls.Add(Me.txtUsrNombre)
        Me.pnlUsuario.Controls.Add(Me.Label1)
        Me.COBISStyleProvider.SetControlStyle(Me.pnlUsuario, "Default")
        Me.pnlUsuario.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.pnlUsuario.Location = New System.Drawing.Point(200, 24)
        Me.pnlUsuario.Name = "pnlUsuario"
        Me.pnlUsuario.Size = New System.Drawing.Size(435, 30)
        Me.pnlUsuario.TabIndex = 1
        Me.pnlUsuario.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.pnlUsuario, "")
        '
        'txtUsrCodigo
        '
        Me.txtUsrCodigo.AsociatedLabelIndex = CType(0, Short)
        Me.COBISViewResizer.SetAutoRelocate(Me.txtUsrCodigo, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtUsrCodigo, False)
        Me.txtUsrCodigo.BackColor = System.Drawing.SystemColors.Control
        Me.txtUsrCodigo.Character = COBISCorp.Framework.UI.Components.ENUM_CHARACTER._LowerCase
        Me.COBISStyleProvider.SetControlStyle(Me.txtUsrCodigo, "Default")
        Me.COBISStyleProvider.SetEnableStyle(Me.txtUsrCodigo, True)
        Me.txtUsrCodigo.Error = CType(0, Short)
        Me.txtUsrCodigo.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtUsrCodigo.HelpLine = Nothing
        Me.txtUsrCodigo.Location = New System.Drawing.Point(112, 5)
        Me.txtUsrCodigo.MaxLength = CType(14, Short)
        Me.txtUsrCodigo.MinChar = CType(0, Short)
        Me.txtUsrCodigo.Name = "txtUsrCodigo"
        Me.txtUsrCodigo.Pendiente = Nothing
        Me.txtUsrCodigo.Range = Nothing
        Me.txtUsrCodigo.Size = New System.Drawing.Size(110, 20)
        Me.txtUsrCodigo.TabIndex = 0
        Me.txtUsrCodigo.TableName = Nothing
        Me.txtUsrCodigo.TitleCatalog = Nothing
        Me.txtUsrCodigo.Type = COBISCorp.Framework.UI.Components.ENUM_TYPE._Alphanumeric
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtUsrCodigo, "")
        '
        'txtUsrNombre
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.txtUsrNombre, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtUsrNombre, False)
        Me.COBISStyleProvider.SetControlStyle(Me.txtUsrNombre, "Default")
        Me.txtUsrNombre.Location = New System.Drawing.Point(228, 5)
        Me.txtUsrNombre.Name = "txtUsrNombre"
        Me.txtUsrNombre.ReadOnly = True
        Me.txtUsrNombre.Size = New System.Drawing.Size(200, 20)
        Me.txtUsrNombre.TabIndex = 1
        Me.txtUsrNombre.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtUsrNombre, "")
        '
        'Label1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label1, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label1, False)
        Me.Label1.AutoSize = True
        Me.COBISStyleProvider.SetControlStyle(Me.Label1, "Default")
        Me.Label1.Location = New System.Drawing.Point(12, 8)
        Me.Label1.Name = "Label1"
        Me.COBISResourceProvider.SetResourceID(Me.Label1, "500366")
        Me.Label1.Size = New System.Drawing.Size(50, 13)
        Me.Label1.TabIndex = 105
        Me.Label1.Text = "*Usuario:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label1, "")
        '
        'chkMoneda
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.chkMoneda, False)
        Me.COBISViewResizer.SetAutoResize(Me.chkMoneda, False)
        Me.chkMoneda.AutoSize = True
        Me.chkMoneda.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.chkMoneda, "Default")
        Me.chkMoneda.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkMoneda.Location = New System.Drawing.Point(14, 217)
        Me.chkMoneda.Name = "chkMoneda"
        Me.COBISResourceProvider.SetResourceID(Me.chkMoneda, "509540")
        Me.chkMoneda.Size = New System.Drawing.Size(87, 17)
        Me.chkMoneda.TabIndex = 12
        Me.chkMoneda.Text = "*Por moneda"
        Me.chkMoneda.UseVisualStyleBackColor = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.chkMoneda, "")
        '
        'chkCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.chkCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.chkCuenta, False)
        Me.chkCuenta.AutoSize = True
        Me.chkCuenta.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.chkCuenta, "Default")
        Me.chkCuenta.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkCuenta.Location = New System.Drawing.Point(14, 186)
        Me.chkCuenta.Name = "chkCuenta"
        Me.COBISResourceProvider.SetResourceID(Me.chkCuenta, "509539")
        Me.chkCuenta.Size = New System.Drawing.Size(135, 17)
        Me.chkCuenta.TabIndex = 10
        Me.chkCuenta.Text = "*Por número de cuenta"
        Me.chkCuenta.UseVisualStyleBackColor = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.chkCuenta, "")
        '
        'chkValor
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.chkValor, False)
        Me.COBISViewResizer.SetAutoResize(Me.chkValor, False)
        Me.chkValor.AutoSize = True
        Me.chkValor.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.chkValor, "Default")
        Me.chkValor.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkValor.Location = New System.Drawing.Point(14, 155)
        Me.chkValor.Name = "chkValor"
        Me.COBISResourceProvider.SetResourceID(Me.chkValor, "509536")
        Me.chkValor.Size = New System.Drawing.Size(72, 17)
        Me.chkValor.TabIndex = 8
        Me.chkValor.Text = "*Por valor"
        Me.chkValor.UseVisualStyleBackColor = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.chkValor, "")
        '
        'chkHora
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.chkHora, False)
        Me.COBISViewResizer.SetAutoResize(Me.chkHora, False)
        Me.chkHora.AutoSize = True
        Me.chkHora.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.chkHora, "Default")
        Me.chkHora.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkHora.Location = New System.Drawing.Point(14, 124)
        Me.chkHora.Name = "chkHora"
        Me.COBISResourceProvider.SetResourceID(Me.chkHora, "509528")
        Me.chkHora.Size = New System.Drawing.Size(75, 17)
        Me.chkHora.TabIndex = 6
        Me.chkHora.Text = "*Por horas"
        Me.chkHora.UseVisualStyleBackColor = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.chkHora, "")
        '
        'chkNemonico
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.chkNemonico, False)
        Me.COBISViewResizer.SetAutoResize(Me.chkNemonico, False)
        Me.chkNemonico.AutoSize = True
        Me.chkNemonico.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.chkNemonico, "Default")
        Me.chkNemonico.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkNemonico.Location = New System.Drawing.Point(14, 93)
        Me.chkNemonico.Name = "chkNemonico"
        Me.COBISResourceProvider.SetResourceID(Me.chkNemonico, "509527")
        Me.chkNemonico.Size = New System.Drawing.Size(157, 17)
        Me.chkNemonico.TabIndex = 4
        Me.chkNemonico.Text = "*Por código de transacción:"
        Me.chkNemonico.UseVisualStyleBackColor = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.chkNemonico, "")
        '
        'chkSecuencial
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.chkSecuencial, False)
        Me.COBISViewResizer.SetAutoResize(Me.chkSecuencial, False)
        Me.chkSecuencial.AutoSize = True
        Me.chkSecuencial.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.chkSecuencial, "Default")
        Me.chkSecuencial.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkSecuencial.Location = New System.Drawing.Point(14, 62)
        Me.chkSecuencial.Name = "chkSecuencial"
        Me.COBISResourceProvider.SetResourceID(Me.chkSecuencial, "509519")
        Me.chkSecuencial.Size = New System.Drawing.Size(100, 17)
        Me.chkSecuencial.TabIndex = 2
        Me.chkSecuencial.Text = "*Por secuencial"
        Me.chkSecuencial.UseVisualStyleBackColor = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.chkSecuencial, "")
        '
        'chkUsuario
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.chkUsuario, False)
        Me.COBISViewResizer.SetAutoResize(Me.chkUsuario, False)
        Me.chkUsuario.AutoSize = True
        Me.chkUsuario.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.chkUsuario, "Default")
        Me.chkUsuario.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkUsuario.Location = New System.Drawing.Point(14, 31)
        Me.chkUsuario.Name = "chkUsuario"
        Me.COBISResourceProvider.SetResourceID(Me.chkUsuario, "509518")
        Me.chkUsuario.Size = New System.Drawing.Size(138, 17)
        Me.chkUsuario.TabIndex = 0
        Me.chkUsuario.Text = "*Reverso otros usuarios"
        Me.chkUsuario.UseVisualStyleBackColor = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.chkUsuario, "")
        '
        'ugbTransacciones
        '
        Me.ugbTransacciones.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.COBISViewResizer.SetAutoRelocate(Me.ugbTransacciones, False)
        Me.COBISViewResizer.SetAutoResize(Me.ugbTransacciones, False)
        Me.ugbTransacciones.BackColorInternal = System.Drawing.Color.White
        Me.ugbTransacciones.Controls.Add(Me.grdTransacciones)
        Me.COBISStyleProvider.SetControlStyle(Me.ugbTransacciones, "Default")
        Me.ugbTransacciones.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ugbTransacciones.Location = New System.Drawing.Point(8, 287)
        Me.ugbTransacciones.Name = "ugbTransacciones"
        Me.COBISResourceProvider.SetResourceID(Me.ugbTransacciones, "502008")
        Me.ugbTransacciones.Size = New System.Drawing.Size(643, 233)
        Me.ugbTransacciones.TabIndex = 2
        Me.ugbTransacciones.Text = "*Transacciones"
        Me.ugbTransacciones.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.ugbTransacciones, "")
        '
        'grdTransacciones
        '
        Me.grdTransacciones.AccessibleDescription = ""
        Me.grdTransacciones.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.COBISViewResizer.SetAutoRelocate(Me.grdTransacciones, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdTransacciones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.grdTransacciones, "Default")
        Me.grdTransacciones.CursorStyle = COBISCorp.Framework.UI.Components.CursorStyleConstants.CursorStyleUserDefined
        Me.grdTransacciones.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.grdTransacciones.Location = New System.Drawing.Point(6, 19)
        Me.grdTransacciones.Name = "grdTransacciones"
        Me.grdTransacciones.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.grdTransacciones.Sheets.AddRange(New FarPoint.Win.Spread.SheetView() {Me.grdTransacciones_Sheet1})
        Me.grdTransacciones.Size = New System.Drawing.Size(629, 208)
        Me.grdTransacciones.StartingColNumber = 1
        Me.grdTransacciones.StartingRowNumber = 1
        Me.grdTransacciones.TabIndex = 0
        Me.grdTransacciones.UnitType = COBISCorp.Framework.UI.Components.UnitTypeConstants.UnitTypeTwips
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdTransacciones, "")
        '
        'grdTransacciones_Sheet1
        '
        Me.grdTransacciones_Sheet1.Reset()
        Me.grdTransacciones_Sheet1.SheetName = "Sheet1"
        'Formulas and custom names must be loaded with R1C1 reference style
        Me.grdTransacciones_Sheet1.ReferenceStyle = FarPoint.Win.Spread.Model.ReferenceStyle.R1C1
        Me.grdTransacciones_Sheet1.ColumnCount = 1
        Me.grdTransacciones_Sheet1.RowCount = 0
        Me.grdTransacciones_Sheet1.ActiveRowIndex = -1
        Me.grdTransacciones_Sheet1.ColumnHeader.Cells.Get(0, 0).Value = " "
        Me.grdTransacciones_Sheet1.OperationMode = FarPoint.Win.Spread.OperationMode.[ReadOnly]
        Me.grdTransacciones_Sheet1.RowHeader.Columns.Default.Resizable = False
        Me.grdTransacciones_Sheet1.ReferenceStyle = FarPoint.Win.Spread.Model.ReferenceStyle.A1
        Me.grdTransacciones.SetActiveViewport(0, -1, 0)
        '
        'FReversosClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.Color.White
        Me.Controls.Add(Me.ugbTransacciones)
        Me.Controls.Add(Me.ugbBuscar)
        Me.Controls.Add(Me.TSBotones)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Name = "FReversosClass"
        Me.Size = New System.Drawing.Size(658, 528)
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.ugbBuscar, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ugbBuscar.ResumeLayout(False)
        Me.ugbBuscar.PerformLayout()
        Me.pnlMoneda.ResumeLayout(False)
        Me.pnlMoneda.PerformLayout()
        Me.pnlCuenta.ResumeLayout(False)
        Me.pnlCuenta.PerformLayout()
        Me.pnlValor.ResumeLayout(False)
        Me.pnlValor.PerformLayout()
        Me.pnlHora.ResumeLayout(False)
        Me.pnlHora.PerformLayout()
        Me.pnlNemonico.ResumeLayout(False)
        Me.pnlNemonico.PerformLayout()
        Me.pnlSecuencial.ResumeLayout(False)
        Me.pnlSecuencial.PerformLayout()
        Me.pnlUsuario.ResumeLayout(False)
        Me.pnlUsuario.PerformLayout()
        CType(Me.ugbTransacciones, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ugbTransacciones.ResumeLayout(False)
        CType(Me.grdTransacciones, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.grdTransacciones_Sheet1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents COBISViewResizer As COBISCorp.eCOBIS.Commons.COBISViewResizer
    Public WithEvents COBISResourceProvider As COBISCorp.Framework.UI.Components.COBISResourceProvider
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguiente As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents COBISStyleProvider As COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider
    Friend WithEvents ugbBuscar As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents ugbTransacciones As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents pnlMoneda As System.Windows.Forms.Panel
    Friend WithEvents pnlCuenta As System.Windows.Forms.Panel
    Friend WithEvents pnlValor As System.Windows.Forms.Panel
    Friend WithEvents Label8 As System.Windows.Forms.Label
    Friend WithEvents Label7 As System.Windows.Forms.Label
    Friend WithEvents pnlHora As System.Windows.Forms.Panel
    Friend WithEvents mskHoraFin As System.Windows.Forms.MaskedTextBox
    Friend WithEvents mskHoraIni As System.Windows.Forms.MaskedTextBox
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents pnlNemonico As System.Windows.Forms.Panel
    Friend WithEvents txtNemonico As COBISCorp.Framework.UI.Components.COBISValidTextBox
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents pnlSecuencial As System.Windows.Forms.Panel
    Friend WithEvents txtSecFin As COBISCorp.Framework.UI.Components.COBISValidTextBox
    Friend WithEvents txtSecIni As COBISCorp.Framework.UI.Components.COBISValidTextBox
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents pnlUsuario As System.Windows.Forms.Panel
    Friend WithEvents txtUsrNombre As System.Windows.Forms.TextBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents chkMoneda As System.Windows.Forms.CheckBox
    Friend WithEvents chkCuenta As System.Windows.Forms.CheckBox
    Friend WithEvents chkValor As System.Windows.Forms.CheckBox
    Friend WithEvents chkHora As System.Windows.Forms.CheckBox
    Friend WithEvents chkNemonico As System.Windows.Forms.CheckBox
    Friend WithEvents chkSecuencial As System.Windows.Forms.CheckBox
    Friend WithEvents chkUsuario As System.Windows.Forms.CheckBox
    Friend WithEvents mskValorFin As COBISCorp.Framework.UI.Components.COBISMaskedInBox
    Friend WithEvents mskValorIni As COBISCorp.Framework.UI.Components.COBISMaskedInBox
    Public WithEvents mskCuenta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Friend WithEvents Label9 As System.Windows.Forms.Label
    Friend WithEvents txtCodMoneda As COBISCorp.Framework.UI.Components.COBISValidTextBox
    Friend WithEvents Label10 As System.Windows.Forms.Label
    Friend WithEvents txtNomMoneda As System.Windows.Forms.TextBox
    Friend WithEvents txtNomCuenta As System.Windows.Forms.TextBox
    Friend WithEvents txtUsrCodigo As COBISCorp.Framework.UI.Components.COBISValidTextBox
    Friend WithEvents grdTransacciones As COBISCorp.Framework.UI.Components.COBISSpread
    Friend WithEvents grdTransacciones_Sheet1 As FarPoint.Win.Spread.SheetView

End Class
