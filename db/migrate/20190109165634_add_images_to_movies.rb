class AddImagesToMovies < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :inmage, :string
  end
end
