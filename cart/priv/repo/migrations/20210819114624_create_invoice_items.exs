defmodule Cart.Repo.Migrations.CreateInvoiceItems do
  use Ecto.Migration

  def change do
    create table(:invoice_items, primary_key: false) do
      add :id, :uuid, primary_key: true
      # references creates the field invoice_id with a constraint in the database that references the "invoices" table
      add :invoice_id, references(:invoices, type: :uuid, null: false)
      add :item_id, references(:items, type: :uuid, null: false)
      add :quantity, :decimal, precision: 12, scale: 2
      add :sub_total, :decimal, precision: 12, scale: 2 # 12 digits and 2 decimal places

      timestamps()
    end

    # create index(:invoice_items, [:invoice_id]) creates the index "invoice_items_invoice_id_index".
    create index(:invoice_items, [:invoice_id])
    create index(:invoice_items, [:item_id])
  end
end
