using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics.Eventing.Reader;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace WindowsFormsApp1
{
    public partial class Form2 : Form
    {
        Form1 frm1 = new Form1();
        public Form2()
        {
            InitializeComponent();
            //se deshabilita el boton para crear usuario a quien no tenga el perfil de administrador
            if (Form1.rol == "1")
            {
                button1.Enabled = true;
            }
            else
            {
                button1.Enabled = false;
            }
        }
        
        string rol;

        private void Form2_Load(object sender, EventArgs e)
        {
            // TODO: esta línea de código carga datos en la tabla 'app1DataSet.users_view' Puede moverla o quitarla según sea necesario.
            this.users_viewTableAdapter.Fill(this.app1DataSet.users_view);
            // TODO: esta línea de código carga datos en la tabla 'app1DataSet.user_connected' Puede moverla o quitarla según sea necesario.
            this.user_connectedTableAdapter.Fill(this.app1DataSet.user_connected);
        }

        //La acción de este botón envia los parametros del formulario al procedimiento almacenado en base de datos que crea los usuarios
        private void button1_Click(object sender, EventArgs e)
        {
            
            if (textBox1.Text.ToString() == "" | textBox2.Text.ToString() == "" | textBox3.Text.ToString() == "" | textBox4.Text.ToString() == "" | listBox1.Text.ToString() == "")
            {
                MessageBox.Show("All the fileds are required");
            }
            else
            { 
                if (listBox1.Text.ToString() == "Administrator")
                {
                     rol = "1";
                }
                else if (listBox1.Text.ToString() == "Managment")
                {
                     rol = "2";
                }


                {
                    string message = string.Empty;
                    try
                    {
                        SqlConnection conn = new SqlConnection("server=JOSEDAVID ; database=App1 ; integrated security = true");
                        conn.Open();
                        SqlCommand cmd = new SqlCommand("[SP_User_administration]", conn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("opt", 1);
                        cmd.Parameters.AddWithValue("name", textBox1.Text.ToString());
                        cmd.Parameters.AddWithValue("l_name", textBox2.Text.ToString());
                        cmd.Parameters.AddWithValue("user", textBox3.Text.ToString());
                        cmd.Parameters.AddWithValue("pass", textBox4.Text.ToString());
                        cmd.Parameters.AddWithValue("rol", rol);
                        cmd.Parameters.Add("@mess", SqlDbType.NVarChar, 400);
                        cmd.Parameters["@mess"].Direction = ParameterDirection.Output;
                        cmd.ExecuteNonQuery();
                        message = (string)cmd.Parameters["@mess"].Value;

                        MessageBox.Show(message, "...::: App1 :::...", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    
                        conn.Close();
                    }
                    catch (Exception p)
                    {
                        MessageBox.Show(p.Message);
                    }
                }

                // TODO: esta línea de código carga datos en la tabla 'app1DataSet.users_view' Puede moverla o quitarla según sea necesario.
                this.users_viewTableAdapter.Fill(this.app1DataSet.users_view);
            }
        }

        private void Form2_FormClosed(object sender, FormClosedEventArgs e)
        {
            Form1 frm1 = new Form1();
            frm1.login("0", Form1.user, Form1.pass);
            Application.Exit();
        }

    }
}
