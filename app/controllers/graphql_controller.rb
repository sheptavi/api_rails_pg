class GraphqlController < ApplicationController
  def execute
    result = ApiRailsPgSchema.execute(
      params[:query],
      variables: params[:variables] || {},
      context: {}
    )
    render json: result
  end
end