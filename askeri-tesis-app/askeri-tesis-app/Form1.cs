using Npgsql;
using System;
using System.Data;
using System.Windows.Forms;

namespace askeri_tesis_app
{
    public partial class Form1 : Form
    {
        private readonly NpgsqlConnection connect;

        public Form1()
        {
            InitializeComponent();
            connect = new NpgsqlConnection("server=localhost;port=5433;UserId=postgres;password=252412;database=database-askeri-tesis");
        }

        // ComboBox'ý doldur
        private void FillComboBox(ComboBox comboBox, string query, string valueMember, string displayMember)
        {
            try
            {
                using (NpgsqlDataAdapter adapter = new NpgsqlDataAdapter(query, connect))
                {
                    DataTable table = new DataTable();
                    adapter.Fill(table);

                    comboBox.DataSource = table;
                    comboBox.ValueMember = valueMember;
                    comboBox.DisplayMember = displayMember;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"ComboBox doldurulurken hata oluþtu: {ex.Message}");
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                string query = "SELECT * FROM calisan";
                using (NpgsqlDataAdapter adapt = new NpgsqlDataAdapter(query, connect))
                {
                    DataSet ds = new DataSet();
                    adapt.Fill(ds);
                    dataGridView1.DataSource = ds.Tables[0];
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Verileri çekerken hata oluþtu: {ex.Message}");
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            try
            {
                connect.Open();

                // Çalýþan ekleme
                string queryCalisan = "INSERT INTO calisan (calisan_id, ad, soyad, maas, dogum_tarihi, cinsiyet, iletisim, adres, mezuniyet, medeni_hali, is_tanimi, is_durumu, sigorta_id) " +
                                      "VALUES (@calisan_id, @ad, @soyad, @maas, @dogum_tarihi, @cinsiyet, @iletisim, @adres, @mezuniyet, @medeni_hali, @is_tanimi, @is_durumu, @sigorta_id)";
                NpgsqlCommand command1 = new NpgsqlCommand(queryCalisan, connect);

                int calisanId = GetNextId("calisan", "calisan_id");
                command1.Parameters.AddWithValue("@calisan_id", calisanId);

                command1.Parameters.AddWithValue("@ad", textBox1.Text);
                command1.Parameters.AddWithValue("@soyad", textBox2.Text);
                command1.Parameters.AddWithValue("@maas", int.Parse(textBox6.Text));
                command1.Parameters.AddWithValue("@dogum_tarihi", dateTimePicker1.Value);
                command1.Parameters.AddWithValue("@cinsiyet", comboBox1.Text);
                command1.Parameters.AddWithValue("@iletisim", textBox7.Text);
                command1.Parameters.AddWithValue("@adres", textBox3.Text);
                command1.Parameters.AddWithValue("@mezuniyet", textBox4.Text);
                command1.Parameters.AddWithValue("@medeni_hali", comboBox2.Text);
                command1.Parameters.AddWithValue("@is_tanimi", textBox5.Text);
                command1.Parameters.AddWithValue("@is_durumu", comboBox3.Text);
                command1.Parameters.AddWithValue("@sigorta_id", comboBox4.SelectedValue);

                command1.ExecuteNonQuery();

                // Asker veya asker olmayan ekleme
                if (checkBox1.Checked)
                {
                    string queryAsker = "INSERT INTO asker (asker_id, calisan_id, rutbe_id, silah_id, silah_disi_id, ad, soyad, maas, dogum_tarihi, cinsiyet, iletisim, adres, mezuniyet, medeni_hali, is_tanimi, is_durumu, sigorta_id) " +
                                        "VALUES (@asker_id, @calisan_id, @rutbe_id, @silah_id, @silah_disi_id, @ad, @soyad, @maas, @dogum_tarihi, @cinsiyet, @iletisim, @adres, @mezuniyet, @medeni_hali, @is_tanimi, @is_durumu, @sigorta_id)";
                    NpgsqlCommand command2 = new NpgsqlCommand(queryAsker, connect);

                    // Asker ID'yi almak için
                    int askerId = GetNextId("asker", "asker_id");
                    command2.Parameters.AddWithValue("@asker_id", askerId);

                    command2.Parameters.AddWithValue("@calisan_id", calisanId);
                    command2.Parameters.AddWithValue("@rutbe_id", comboBox5.SelectedValue);
                    command2.Parameters.AddWithValue("@silah_id", comboBox6.SelectedValue);
                    command2.Parameters.AddWithValue("@silah_disi_id", comboBox7.SelectedValue);
                    command2.Parameters.AddWithValue("@ad", textBox1.Text);
                    command2.Parameters.AddWithValue("@soyad", textBox2.Text);
                    command2.Parameters.AddWithValue("@maas", int.Parse(textBox6.Text));
                    command2.Parameters.AddWithValue("@dogum_tarihi", dateTimePicker1.Value);
                    command2.Parameters.AddWithValue("@cinsiyet", comboBox1.Text);
                    command2.Parameters.AddWithValue("@iletisim", textBox7.Text);
                    command2.Parameters.AddWithValue("@adres", textBox3.Text);
                    command2.Parameters.AddWithValue("@mezuniyet", textBox4.Text);
                    command2.Parameters.AddWithValue("@medeni_hali", comboBox2.Text);
                    command2.Parameters.AddWithValue("@is_tanimi", textBox5.Text);
                    command2.Parameters.AddWithValue("@is_durumu", comboBox3.Text);
                    command2.Parameters.AddWithValue("@sigorta_id", comboBox4.SelectedValue);

                    command2.ExecuteNonQuery();
                }
                else if (!checkBox1.Checked)
                {
                    string queryAskerOlmayan = "INSERT INTO asker_olmayan (asker_olmayan_id, calisan_id, silah_disi_id, ad, soyad, maas, dogum_tarihi, cinsiyet, iletisim, adres, mezuniyet, medeni_hali, is_tanimi, is_durumu, sigorta_id) " +
                                               "VALUES (@asker_olmayan_id, @calisan_id, @silah_disi_id, @ad, @soyad, @maas, @dogum_tarihi, @cinsiyet, @iletisim, @adres, @mezuniyet, @medeni_hali, @is_tanimi, @is_durumu, @sigorta_id)";
                    NpgsqlCommand command3 = new NpgsqlCommand(queryAskerOlmayan, connect);

                    int askerOlmayanId = GetNextId("asker_olmayan", "asker_olmayan_id");
                    command3.Parameters.AddWithValue("@asker_olmayan_id", askerOlmayanId);

                    command3.Parameters.AddWithValue("@calisan_id", calisanId);
                    command3.Parameters.AddWithValue("@silah_disi_id", comboBox7.SelectedValue);
                    command3.Parameters.AddWithValue("@ad", textBox1.Text);
                    command3.Parameters.AddWithValue("@soyad", textBox2.Text);
                    command3.Parameters.AddWithValue("@maas", int.Parse(textBox6.Text));
                    command3.Parameters.AddWithValue("@dogum_tarihi", dateTimePicker1.Value);
                    command3.Parameters.AddWithValue("@cinsiyet", comboBox1.Text);
                    command3.Parameters.AddWithValue("@iletisim", textBox7.Text);
                    command3.Parameters.AddWithValue("@adres", textBox3.Text);
                    command3.Parameters.AddWithValue("@mezuniyet", textBox4.Text);
                    command3.Parameters.AddWithValue("@medeni_hali", comboBox2.Text);
                    command3.Parameters.AddWithValue("@is_tanimi", textBox5.Text);
                    command3.Parameters.AddWithValue("@is_durumu", comboBox3.Text);
                    command3.Parameters.AddWithValue("@sigorta_id", comboBox4.SelectedValue);

                    command3.ExecuteNonQuery();
                }

                MessageBox.Show("Çalýþan eklemesi baþarýyla gerçekleþti.");
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ekleme sýrasýnda bir hata oluþtu: {ex.Message}");
            }
            finally
            {
                connect.Close();
            }
        }


        // ID için bir sonraki deðeri getiren fonksiyon
        private int GetNextId(string tableName, string columnName)
        {
            int nextId = 1;
            string query = $"SELECT MAX({columnName}) FROM {tableName}";
            using (NpgsqlCommand command = new NpgsqlCommand(query, connect))
            {
                object result = command.ExecuteScalar();
                if (result != DBNull.Value && result != null)
                {
                    nextId = Convert.ToInt32(result) + 1;
                }
            }

            return nextId;
        }

        private void Form1_Load_1(object sender, EventArgs e)
        {
            try
            {
                // ComboBox'larý doldur
                FillComboBox(comboBox4, "SELECT sigorta_id, sigorta_adi FROM sigorta", "sigorta_id", "sigorta_adi");
                FillComboBox(comboBox5, "SELECT rutbe_id, rutbe_adi FROM rutbe", "rutbe_id", "rutbe_adi");
                FillComboBox(comboBox6, "SELECT silah_id, silah_adi FROM silah", "silah_id", "silah_adi");
                FillComboBox(comboBox7, "SELECT silah_disi_id, adi FROM silah_disi", "silah_disi_id", "adi");
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Veritabanýna baðlanýrken bir hata oluþtu: {ex.Message}");
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            try
            {
                // Seçilen çalýþanýn ID'sini al
                int calisanId = Convert.ToInt32(dataGridView1.CurrentRow.Cells["calisan_id"].Value);

                // Asker veya Asker Olmayan'ý silmek için
                string queryAsker = "DELETE FROM asker WHERE calisan_id = @calisan_id";
                string queryAskerOlmayan = "DELETE FROM asker_olmayan WHERE calisan_id = @calisan_id";

                // Çalýþaný silmek için
                string queryCalisan = "DELETE FROM calisan WHERE calisan_id = @calisan_id";

                connect.Open();

                // Önce asker veya asker olmayaný sil
                NpgsqlCommand command1 = new NpgsqlCommand(queryAsker, connect);
                command1.Parameters.AddWithValue("@calisan_id", calisanId);
                command1.ExecuteNonQuery();

                NpgsqlCommand command2 = new NpgsqlCommand(queryAskerOlmayan, connect);
                command2.Parameters.AddWithValue("@calisan_id", calisanId);
                command2.ExecuteNonQuery();

                // Ardýndan çalýþanýn kendisini sil
                NpgsqlCommand command3 = new NpgsqlCommand(queryCalisan, connect);
                command3.Parameters.AddWithValue("@calisan_id", calisanId);
                command3.ExecuteNonQuery();

                MessageBox.Show("Çalýþan ve ilgili kayýtlar baþarýyla silindi.");
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Silme iþlemi sýrasýnda hata oluþtu: {ex.Message}");
            }
            finally
            {
                connect.Close();
            }
        }


        private void button4_Click(object sender, EventArgs e)
        {
            try
            {
                // Seçilen çalýþanýn ID'sini al
                int calisanId = Convert.ToInt32(dataGridView1.CurrentRow.Cells["calisan_id"].Value);

                // Güncelleme sorgusu
                string query = "UPDATE calisan SET ad = @ad, soyad = @soyad, maas = @maas, dogum_tarihi = @dogum_tarihi, cinsiyet = @cinsiyet, " +
                               "iletisim = @iletisim, adres = @adres, mezuniyet = @mezuniyet, medeni_hali = @medeni_hali, is_tanimi = @is_tanimi, " +
                               "is_durumu = @is_durumu, sigorta_id = @sigorta_id WHERE calisan_id = @calisan_id";

                connect.Open();

                NpgsqlCommand command = new NpgsqlCommand(query, connect);
                command.Parameters.AddWithValue("@calisan_id", calisanId);
                command.Parameters.AddWithValue("@ad", textBox1.Text);
                command.Parameters.AddWithValue("@soyad", textBox2.Text);
                command.Parameters.AddWithValue("@maas", int.Parse(textBox6.Text));
                command.Parameters.AddWithValue("@dogum_tarihi", dateTimePicker1.Value);
                command.Parameters.AddWithValue("@cinsiyet", comboBox1.Text);
                command.Parameters.AddWithValue("@iletisim", textBox7.Text);
                command.Parameters.AddWithValue("@adres", textBox3.Text);
                command.Parameters.AddWithValue("@mezuniyet", textBox4.Text);
                command.Parameters.AddWithValue("@medeni_hali", comboBox2.Text);
                command.Parameters.AddWithValue("@is_tanimi", textBox5.Text);
                command.Parameters.AddWithValue("@is_durumu", comboBox3.Text);
                command.Parameters.AddWithValue("@sigorta_id", comboBox4.SelectedValue);

                command.ExecuteNonQuery();

                // Eðer asker olan kiþi güncelleniyorsa
                if (checkBox1.Checked)
                {
                    string queryAsker = "UPDATE asker SET rutbe_id = @rutbe_id, silah_id = @silah_id, silah_disi_id = @silah_disi_id, " +
                                        "ad = @ad, soyad = @soyad, maas = @maas, dogum_tarihi = @dogum_tarihi, cinsiyet = @cinsiyet, iletisim = @iletisim, " +
                                        "adres = @adres, mezuniyet = @mezuniyet, medeni_hali = @medeni_hali, is_tanimi = @is_tanimi, is_durumu = @is_durumu, " +
                                        "sigorta_id = @sigorta_id WHERE calisan_id = @calisan_id";
                    NpgsqlCommand commandAsker = new NpgsqlCommand(queryAsker, connect);

                    commandAsker.Parameters.AddWithValue("@calisan_id", calisanId);
                    commandAsker.Parameters.AddWithValue("@rutbe_id", comboBox5.SelectedValue);
                    commandAsker.Parameters.AddWithValue("@silah_id", comboBox6.SelectedValue);
                    commandAsker.Parameters.AddWithValue("@silah_disi_id", comboBox7.SelectedValue);
                    commandAsker.Parameters.AddWithValue("@ad", textBox1.Text);
                    commandAsker.Parameters.AddWithValue("@soyad", textBox2.Text);
                    commandAsker.Parameters.AddWithValue("@maas", int.Parse(textBox6.Text));
                    commandAsker.Parameters.AddWithValue("@dogum_tarihi", dateTimePicker1.Value);
                    commandAsker.Parameters.AddWithValue("@cinsiyet", comboBox1.Text);
                    commandAsker.Parameters.AddWithValue("@iletisim", textBox7.Text);
                    commandAsker.Parameters.AddWithValue("@adres", textBox3.Text);
                    commandAsker.Parameters.AddWithValue("@mezuniyet", textBox4.Text);
                    commandAsker.Parameters.AddWithValue("@medeni_hali", comboBox2.Text);
                    commandAsker.Parameters.AddWithValue("@is_tanimi", textBox5.Text);
                    commandAsker.Parameters.AddWithValue("@is_durumu", comboBox3.Text);
                    commandAsker.Parameters.AddWithValue("@sigorta_id", comboBox4.SelectedValue);

                    commandAsker.ExecuteNonQuery();
                }

                // Eðer asker olmayan kiþi güncelleniyorsa
                else if (!checkBox1.Checked)
                {
                    string queryAskerOlmayan = "UPDATE asker_olmayan SET silah_disi_id = @silah_disi_id, ad = @ad, soyad = @soyad, maas = @maas, " +
                                                "dogum_tarihi = @dogum_tarihi, cinsiyet = @cinsiyet, iletisim = @iletisim, adres = @adres, mezuniyet = @mezuniyet, " +
                                                "medeni_hali = @medeni_hali, is_tanimi = @is_tanimi, is_durumu = @is_durumu, sigorta_id = @sigorta_id " +
                                                "WHERE calisan_id = @calisan_id";
                    NpgsqlCommand commandAskerOlmayan = new NpgsqlCommand(queryAskerOlmayan, connect);

                    commandAskerOlmayan.Parameters.AddWithValue("@calisan_id", calisanId);
                    commandAskerOlmayan.Parameters.AddWithValue("@silah_disi_id", comboBox7.SelectedValue);
                    commandAskerOlmayan.Parameters.AddWithValue("@ad", textBox1.Text);
                    commandAskerOlmayan.Parameters.AddWithValue("@soyad", textBox2.Text);
                    commandAskerOlmayan.Parameters.AddWithValue("@maas", int.Parse(textBox6.Text));
                    commandAskerOlmayan.Parameters.AddWithValue("@dogum_tarihi", dateTimePicker1.Value);
                    commandAskerOlmayan.Parameters.AddWithValue("@cinsiyet", comboBox1.Text);
                    commandAskerOlmayan.Parameters.AddWithValue("@iletisim", textBox7.Text);
                    commandAskerOlmayan.Parameters.AddWithValue("@adres", textBox3.Text);
                    commandAskerOlmayan.Parameters.AddWithValue("@mezuniyet", textBox4.Text);
                    commandAskerOlmayan.Parameters.AddWithValue("@medeni_hali", comboBox2.Text);
                    commandAskerOlmayan.Parameters.AddWithValue("@is_tanimi", textBox5.Text);
                    commandAskerOlmayan.Parameters.AddWithValue("@is_durumu", comboBox3.Text);
                    commandAskerOlmayan.Parameters.AddWithValue("@sigorta_id", comboBox4.SelectedValue);

                    commandAskerOlmayan.ExecuteNonQuery();
                }

                MessageBox.Show("Çalýþan güncellemesi baþarýyla gerçekleþti.");
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Güncelleme iþlemi sýrasýnda hata oluþtu: {ex.Message}");
            }
            finally
            {
                connect.Close();
            }
        }

    }
}