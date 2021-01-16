# 各agentから取得したデータの処理
class Build
  attr_reader :agent

  def initialize(agent)
    @agent = agent
  end

  def save_db
    data_associated_organization = save_organization(fetch_data)
    save_job_offers(data_associated_organization)
  end

  private

  def fetch_data
    agent.fetch_data
  end

  def save_organization(datas)
    return datas.map{ |data| 
      organization = Organization.find_or_create_by(
        name: data[:organization_name], 
        url:  data[:organization_url]
      )
      data.merge(organization_id: organization.id)
    }
  end

  def save_job_offers(datas)
    datas.select{ |data| 
      JobOffer.find_or_create_by(
        title:           data[:title],
        url:             data[:job_offer_url],
        event_date:      data[:event_date],
        organization_id: data[:organization_id]
      )
    }
  end
end
