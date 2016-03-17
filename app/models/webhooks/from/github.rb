class Webhooks::From::Github < Webhooks::From::Base
  PATTERNS = %w(comment pull_request issue)

  def comment
    assigned? ? 'assigned' : search_content('body')
  end

  def url
    search_content('html_url')
  end

  def mentions
    if assigned?
      [search_content('assignee', 'login')].compact
    else
      super
    end
  end

  def assigned?
    @payload.dig('action') == 'assigned'
  end

  def additional_message
    assigned? ? "you've been assigned" : super
  end
end
