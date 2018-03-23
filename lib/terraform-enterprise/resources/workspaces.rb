require "terraform-enterprise/resources_client"

module TerraformEnterprise  
  class Workspaces < ResourcesClient
    def list(params={})
      @client.get(:organizations, params[:organization], :workspaces)
    end

    def get(params={})
      @client.get(:organizations, params[:organization], :workspaces, params[:workspace])
    end

    def create(params={})
      org = params.delete(:organization)
      data = {
        attributes: params,
        type: 'workspaces'
      }

      @client.post(:organizations, org, :workspaces, data: data)
    end

    def update(params={})
      org = params.delete(:organization)
      id  = params.delete(:workspace)

      data = {
        attributes: params,
        type: 'workspaces'
      }

      @client.patch(:organizations, org, :workspaces, id, data: data)
    end

    def delete(params={})
      @client.delete(:organizations, params[:organization], :workspaces, params[:workspace])
    end

    def action(params={})
      @client.post(:workspaces, params[:id], :actions, params[:action].to_sym)
    end
  end
end