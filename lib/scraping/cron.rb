# モデルに抽出したデータを渡す
class Cron
  attr_reader :data_hash_lists, :organization, :job

  def initialize(args)
    @data_hash_lists = args[:agent].execute
    @organization = Organization.new
    @job = Job.new
  end

  def build
    organization.iterate_find_or_create(parse_organizations)
    job.iterate_find_or_create(parse_jobs)
  end

  private
  def parse_organizations
    data_hash_lists.map{|list| 
      {
        name: list[:organization_name],
        url:  list[:organization_url],
      }
    }
  end

  def parse_jobs
    data_hash_lists.map{|list| 
      {
        title:      list[:title],
        url:        list[:job_url], 
        event_date: list[:event_date],
      }.merge(organization_id: find_organization_id(list[:organization_url]))
    }
  end

  def find_organization_id(url)
    organization.find_id_by_url(url)
  end
end