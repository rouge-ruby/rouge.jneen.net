module FixtureLoader
  def load_fixture(file_name)
    File.read(Rails.root.join('spec', 'fixtures', file_name))
  end
end
