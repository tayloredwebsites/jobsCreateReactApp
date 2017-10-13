class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :recruiter
      t.string :company

      t.timestamps
    end
  end
end
